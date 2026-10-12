import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:chatwit_flutter/core/client.dart';

class PollCard extends StatefulWidget {
  const PollCard({
    super.key,
    required this.poll,
  });

  final Poll poll;

  @override
  State<PollCard> createState() => _PollCardState();
}

class _PollCardState extends State<PollCard> {
  List<String> _options = const [];
  List<int> _results = const [];
  int _selectedIndex = -1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _options = _decodeOptions(widget.poll.options);
    _results = List<int>.filled(_options.length, 0);
    _loadSummary();
  }

  List<String> _decodeOptions(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.map((item) => item.toString()).toList();
      }
    } catch (_) {}

    return const <String>[];
  }

  Future<void> _loadSummary() async {
    if (widget.poll.id == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      final summary = await client.poll.getPollSummary(widget.poll.id!);
      if (!mounted) return;

      final newOptions =
          (summary['options'] as List?)
              ?.map((option) => option.toString())
              .toList() ??
          _options;
      final newResults =
          (summary['results'] as List?)
              ?.map((value) => int.tryParse(value.toString()) ?? 0)
              .toList() ??
          _results;

      setState(() {
        _options = newOptions;
        _results = List<int>.filled(newOptions.length, 0);
        for (var i = 0; i < newResults.length && i < _results.length; i++) {
          _results[i] = newResults[i];
        }
        _isLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _vote(int index) async {
    if (widget.poll.id == null || _selectedIndex >= 0) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await client.poll.vote(
        pollId: widget.poll.id!,
        optionIndex: index,
      );

      final resultList = response['results'] as List<dynamic>? ?? const [];
      final nextResults = resultList
          .map((item) => int.tryParse(item.toString()) ?? 0)
          .toList();

      if (mounted) {
        setState(() {
          _selectedIndex = index;
          _results = List<int>.filled(_options.length, 0);
          for (var i = 0; i < nextResults.length && i < _results.length; i++) {
            _results[i] = nextResults[i];
          }
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to submit vote right now.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalVotes = _results.fold<int>(0, (sum, value) => sum + value);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.poll.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (_options.isEmpty)
              const Text('No poll options available.')
            else
              ...List.generate(_options.length, (index) {
                final percent = totalVotes == 0
                    ? 0.0
                    : (_results[index] / totalVotes);
                final selected = _selectedIndex == index;

                return GestureDetector(
                  onTap: _isLoading || _selectedIndex >= 0
                      ? null
                      : () => _vote(index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selected
                          ? Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.08)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                _options[index],
                                style: TextStyle(
                                  fontWeight: selected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            if (totalVotes > 0)
                              Text(
                                '${_results[index]}',
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: percent,
                            minHeight: 8,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF374151),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.how_to_vote_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  totalVotes == 1 ? '1 vote' : '$totalVotes votes',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
