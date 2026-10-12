import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class PollEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Poll> createPoll(
    Session session, {
    required String question,
    required List<String> options,
    DateTime? expiresAt,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('You must be logged in to create a poll.');
    }

    final cleanedQuestion = question.trim();
    final cleanedOptions = options
        .map((option) => option.trim())
        .where((option) => option.isNotEmpty)
        .toList();

    if (cleanedQuestion.isEmpty) {
      throw Exception('Poll question cannot be empty.');
    }
    if (cleanedOptions.length < 2 || cleanedOptions.length > 4) {
      throw Exception('Polls must have between 2 and 4 options.');
    }

    final poll = Poll(
      question: cleanedQuestion,
      options: jsonEncode(cleanedOptions),
      createdByUserId: authInfo.userIdentifier,
      createdAt: DateTime.now(),
      totalVotes: 0,
      isClosed: false,
      expiresAt: expiresAt ?? DateTime.now().add(const Duration(days: 7)),
    );

    return Poll.db.insertRow(session, poll);
  }

  Future<List<Poll>> getPolls(Session session, {int limit = 20}) async {
    return Poll.db.find(
      session,
      orderBy: (t) => t.createdAt.desc(),
      limit: limit,
    );
  }

  Future<Poll?> getPoll(Session session, int pollId) async {
    return Poll.db.findById(session, pollId);
  }

  Future<Map<String, dynamic>> vote(
    Session session, {
    required int pollId,
    required int optionIndex,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('You must be logged in to vote.');
    }

    final poll = await Poll.db.findById(session, pollId);
    if (poll == null) {
      throw Exception('Poll not found.');
    }

    final options = _decodeOptions(poll.options);
    if (optionIndex < 0 || optionIndex >= options.length) {
      throw Exception('Invalid option selection.');
    }

    final existingVote = await PollVote.db.findFirstRow(
      session,
      where: (t) =>
          t.pollId.equals(pollId) & t.userId.equals(authInfo.userIdentifier),
    );

    if (existingVote != null) {
      throw Exception('You have already voted in this poll.');
    }

    await PollVote.db.insertRow(
      session,
      PollVote(
        pollId: pollId,
        userId: authInfo.userIdentifier,
        optionIndex: optionIndex,
        createdAt: DateTime.now(),
      ),
    );

    poll.totalVotes = poll.totalVotes + 1;
    await Poll.db.updateRow(session, poll);

    final counts = await _getCounts(session, pollId, options.length);
    return {
      'pollId': pollId,
      'optionIndex': optionIndex,
      'totalVotes': poll.totalVotes,
      'results': counts,
      'options': options,
    };
  }

  Future<Map<String, dynamic>> getPollSummary(
    Session session,
    int pollId,
  ) async {
    final poll = await Poll.db.findById(session, pollId);
    if (poll == null) {
      throw Exception('Poll not found.');
    }

    final options = _decodeOptions(poll.options);
    final results = await _getCounts(session, pollId, options.length);

    return {
      'pollId': pollId,
      'question': poll.question,
      'options': options,
      'totalVotes': poll.totalVotes,
      'results': results,
      'createdByUserId': poll.createdByUserId,
      'createdAt': poll.createdAt,
      'expiresAt': poll.expiresAt,
    };
  }

  List<String> _decodeOptions(String rawOptions) {
    final decoded = jsonDecode(rawOptions);
    if (decoded is List) {
      return decoded.map((item) => item.toString()).toList();
    }
    return const <String>[];
  }

  Future<List<int>> _getCounts(
    Session session,
    int pollId,
    int optionCount,
  ) async {
    final votes = await PollVote.db.find(
      session,
      where: (t) => t.pollId.equals(pollId),
    );

    final counts = List<int>.filled(optionCount, 0);
    for (final vote in votes) {
      if (vote.optionIndex >= 0 && vote.optionIndex < optionCount) {
        counts[vote.optionIndex] += 1;
      }
    }
    return counts;
  }
}
