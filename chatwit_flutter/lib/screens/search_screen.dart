import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/image_utils.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/screens/profile_screen.dart';
import 'package:chatwit_flutter/features/post_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SearchController _searchController = SearchController();

  List<Post> _searchResults = [];
  List<UserRegistration> _userResults = [];
  bool _isSearching = false;
  Timer? _debounce;

  final List<String> _recentSearches = [];
  final List<String> _categories = const [
    'Technology',
    'Sports',
    'Entertainment',
    'News',
    'Business',
    'Health',
    'Science',
    'Politics',
    'Travel',
    'Food',
    'Fashion',
    'Gaming',
    'Music',
  ];
  Set<String> _selectedCategories = {};
  bool _savingPreferences = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _loadPreferences();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // ── Debounced Search Logic ───────────────────────────────────────────
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _userResults = [];
        _isSearching = false;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      setState(() => _isSearching = true);
      try {
        final trimmedQuery = query.trim();
        final postResults = trimmedQuery.startsWith('#')
            ? await client.post.getPostsByHashtag(
                tag: trimmedQuery.substring(1),
                limit: 20,
                offset: 0,
              )
            : await client.post.searchPosts(trimmedQuery);
        final userResults = await client.userRegistration.searchUsers(
          trimmedQuery.startsWith('@')
              ? trimmedQuery.substring(1)
              : trimmedQuery,
        );
        if (mounted) {
          setState(() {
            _searchResults = postResults;
            _userResults = userResults;
            _isSearching = false;
          });
        }
      } catch (e) {
        debugPrint("Search error: $e");
        if (mounted) setState(() => _isSearching = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        // ── X-Style Profile Icon ───────────────────────────────────────────
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<UserRegistration?>(
            future: client.userRegistration.getUserInfo(
              authManager.authInfo?.authUserId.toString() ?? '',
            ),
            builder: (context, snapshot) {
              return ChatwitImage.avatar(
                snapshot.data?.profileImageUrl,
                radius: 20,
              );
            },
          ),
        ),
        // ── Standard Flutter SearchAnchor ──────────────────────────────────
        title: SearchAnchor(
          searchController: _searchController,
          builder: (context, controller) {
            return SearchBar(
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: () => controller.openView(),
              onChanged: _onSearchChanged,
              leading: const Icon(Icons.search, color: Colors.grey),
              hintText: 'Search Chatwit',
              hintStyle: WidgetStatePropertyAll<TextStyle>(
                TextStyle(color: Colors.grey[600]),
              ),
              elevation: const WidgetStatePropertyAll<double>(0),
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.grey[100]!),
              shape: WidgetStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              constraints: const BoxConstraints(maxHeight: 40),
            );
          },
          suggestionsBuilder: (context, controller) {
            if (controller.text.isEmpty) {
              return [
                if (_recentSearches.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Search for people or posts"),
                  ),
                ..._recentSearches.map(
                  (search) => ListTile(
                    leading: const Icon(Icons.history, color: Colors.grey),
                    title: Text(search),
                    onTap: () {
                      controller.text = search;
                      _onSearchChanged(search);
                    },
                  ),
                ),
              ];
            }

            if (_isSearching) {
              return [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ];
            }

            if (_searchResults.isEmpty && _userResults.isEmpty) {
              return [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No results found"),
                  ),
                ),
              ];
            }

            return [
              if (_userResults.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Accounts",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                ..._userResults.map(
                  (user) => ListTile(
                    leading: ChatwitImage.avatar(
                      user.profileImageUrl,
                      radius: 20,
                    ),
                    title: Text("${user.firstName} ${user.surname}"),
                    subtitle: Text("@${user.username}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            userId: user.authUserId.toString(),
                            userName: "${user.firstName} ${user.surname}",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              if (_searchResults.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Posts",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                ..._searchResults.map((post) => PostCard(post: post)),
              ],
            ];
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).colorScheme.primary,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: "For you"),
            Tab(text: "Trending"),
            Tab(text: "News"),
            Tab(text: "Sports"),
            Tab(text: "Entertainment"),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Choose feed interests',
            onPressed: _showPreferences,
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeed(0),
          _buildFeed(1),
          _buildFeed(2),
          _buildFeed(3),
          _buildFeed(4),
        ],
      ),
    );
  }

  Future<void> _loadPreferences() async {
    try {
      final preferences = await client.userPreference.getUserPreferences();
      if (mounted) setState(() => _selectedCategories = preferences.toSet());
    } catch (error) {
      debugPrint('Could not load feed interests: $error');
    }
  }

  Future<void> _showPreferences() async {
    final selected = Set<String>.from(_selectedCategories);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose what appears in For you',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: _categories
                        .map(
                          (category) => CheckboxListTile(
                            title: Text(category),
                            value: selected.contains(category),
                            onChanged: (checked) => setSheetState(() {
                              if (checked == true) {
                                selected.add(category);
                              } else {
                                selected.remove(category);
                              }
                            }),
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _savingPreferences
                        ? null
                        : () async {
                            setState(() => _savingPreferences = true);
                            try {
                              await client.userPreference.saveUserPreferences(
                                selected.toList(),
                              );
                              if (!mounted) return;
                              setState(() {
                                _selectedCategories = selected;
                                _savingPreferences = false;
                              });
                              if (sheetContext.mounted) {
                                Navigator.pop(sheetContext);
                              }
                            } catch (error) {
                              if (mounted) {
                                setState(() => _savingPreferences = false);
                              }
                              if (sheetContext.mounted) {
                                ScaffoldMessenger.of(sheetContext).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Could not save interests: $error',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                    child: _savingPreferences
                        ? const CircularProgressIndicator()
                        : const Text('Save interests'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeed(int tabIndex) {
    final Future<List<Post>> postsFuture;
    if (tabIndex == 0) {
      postsFuture = client.post.getRecommendedFeed(limit: 30, offset: 0);
    } else if (tabIndex == 1) {
      postsFuture = client.userPreference.getTrendingFeed(limit: 30, offset: 0);
    } else {
      const categoriesByTab = ['News', 'Sports', 'Entertainment'];
      postsFuture = client.userPreference.getTrendingByCategory(
        category: categoriesByTab[tabIndex - 2],
        limit: 30,
      );
    }

    return FutureBuilder<List<Post>>(
      key: ValueKey('$tabIndex-${_selectedCategories.join(',')}'),
      future: postsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Could not load posts: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final posts = snapshot.data!;
        if (posts.isEmpty) {
          return const Center(
            child: Text('No posts available in this feed yet.'),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => setState(() {}),
          color: const Color(0xFF9E9E9E),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) => PostCard(post: posts[index]),
          ),
        );
      },
    );
  }
}
