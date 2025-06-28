import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const NetflixApp());
}

class NetflixApp extends StatelessWidget {
  const NetflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE50914),
        scaffoldBackgroundColor: const Color(0xFF141414),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white, size: 26),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF141414),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFF8C8C8C),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        fontFamily: 'Helvetica',
      ),
      home: const NetflixHomePage(),
    );
  }
}

class NetflixHomePage extends StatefulWidget {
  const NetflixHomePage({super.key});

  @override
  State<NetflixHomePage> createState() => _NetflixHomePageState();
}

class _NetflixHomePageState extends State<NetflixHomePage> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 150 && !_showAppBarTitle) {
        setState(() => _showAppBarTitle = true);
      } else if (_scrollController.offset <= 150 && _showAppBarTitle) {
        setState(() => _showAppBarTitle = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _showAppBarTitle 
            ? const Color(0xFF141414).withValues(alpha: 0.95) 
            : Colors.transparent,
        title: _showAppBarTitle
            ? const Text(
                'NETFLIX',
                style: TextStyle(
                  color: Color(0xFFE50914),
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: 2.0,
                ),
              )
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.cast_outlined),
              onPressed: () {},
              iconSize: 28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {},
              iconSize: 28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE50914), Color(0xFFB20710)],
                  ),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF141414),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF8C8C8C),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 24),
            activeIcon: Icon(Icons.home, size: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset_outlined, size: 24),
            activeIcon: Icon(Icons.videogame_asset, size: 24),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 24),
            activeIcon: Icon(Icons.add_circle, size: 24),
            label: 'New & Hot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_outlined, size: 24),
            activeIcon: Icon(Icons.download, size: 24),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined, size: 24),
            activeIcon: Icon(Icons.menu, size: 24),
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(scrollController: _scrollController);
      case 1:
        return const GamesScreen();
      case 2:
        return const NewScreen();
      case 3:
        return const DownloadsScreen();
      case 4:
        return const MoreScreen();
      default:
        return HomeScreen(scrollController: _scrollController);
    }
  }
}

class HomeScreen extends StatelessWidget {
  final ScrollController scrollController;
  
  const HomeScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const HeroBanner(),
              const SizedBox(height: 30),
              MovieSection(
                title: 'Trending Now',
                movies: trendingMovies,
                isLarge: true,
              ),
              const SizedBox(height: 35),
              MovieSection(title: 'Netflix Originals', movies: netflixOriginals),
              const SizedBox(height: 35),
              MovieSection(title: 'Continue Watching', movies: continueWatching),
              const SizedBox(height: 35),
              MovieSection(title: 'Recommended for You', movies: forYou),
              const SizedBox(height: 35),
              MovieSection(title: 'Action & Adventure', movies: actionMovies),
              const SizedBox(height: 35),
              MovieSection(title: 'Comedy Movies', movies: comedyMovies),
              const SizedBox(height: 35),
              MovieSection(title: 'Documentaries', movies: documentaries),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ],
    );
  }
}

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF141414),
            Colors.transparent,
            Color(0x66000000),
            Color(0xCC141414),
          ],
          stops: [0.0, 0.3, 0.8, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  Colors.grey[800]!,
                  Colors.grey[900]!,
                  const Color(0xFF141414),
                ],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.movie_creation_outlined,
                size: 120,
                color: Color(0xFF404040),
              ),
            ),
          ),
                    Positioned(
            top: 60,
            left: 20,
            child: const Text(
              'NETFLIX',
              style: TextStyle(
                color: Color(0xFFE50914),
                fontWeight: FontWeight.bold,
                fontSize: 32,
                letterSpacing: 3.0,
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTopNavButton('TV Shows'),
                const SizedBox(width: 30),
                _buildTopNavButton('Movies'),
                const SizedBox(width: 30),
                _buildTopNavButton('Categories'),
              ],
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  'STRANGER THINGS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 8,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Thriller • Sci-Fi • Horror',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add, color: Colors.white, size: 32),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'My List',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 40),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 2,
                        ),
                        icon: const Icon(Icons.play_arrow, size: 28),
                        label: const Text(
                          'Play',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.info_outline, color: Colors.white, size: 32),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Info',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavButton(String text) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final bool isLarge;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: isLarge ? 250 : 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(
                movie: movies[index],
                isLarge: isLarge,
                isFirst: index == 0,
              );
            },
          ),
        ),
      ],
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isLarge;
  final bool isFirst;

  const MovieCard({
    super.key,
    required this.movie,
    this.isLarge = false,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    double width = isLarge ? 140 : 130;
    double height = isLarge ? 200 : 180;
    
    return Container(
      width: width,
      margin: EdgeInsets.only(
        right: 12,
        left: isFirst ? 0 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: movie.imageUrl.isNotEmpty
                    ? Image.network(
                        movie.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[800]!,
            Colors.grey[900]!,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.movie_outlined,
            color: Color(0xFF666666),
            size: 40,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              movie.title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class Movie {
  final String title;
  final String imageUrl;
  final String genre;
  final double rating;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.genre,
    required this.rating,
  });
}

List<Movie> trendingMovies = [
  Movie(title: 'Stranger Things', imageUrl: '', genre: 'Sci-Fi', rating: 8.7),
  Movie(title: 'The Witcher', imageUrl: '', genre: 'Fantasy', rating: 8.2),
  Movie(title: 'Money Heist', imageUrl: '', genre: 'Crime', rating: 8.3),
  Movie(title: 'Squid Game', imageUrl: '', genre: 'Thriller', rating: 8.0),
  Movie(title: 'Bridgerton', imageUrl: '', genre: 'Romance', rating: 7.3),
  Movie(title: 'Ozark', imageUrl: '', genre: 'Crime', rating: 8.4),
  Movie(title: 'The Crown', imageUrl: '', genre: 'Biography', rating: 8.6),
  Movie(title: 'Narcos', imageUrl: '', genre: 'Crime', rating: 8.8),
];

List<Movie> netflixOriginals = [
  Movie(title: 'House of Cards', imageUrl: '', genre: 'Drama', rating: 8.7),
  Movie(title: 'Orange Is the New Black', imageUrl: '', genre: 'Comedy', rating: 8.1),
  Movie(title: 'Narcos', imageUrl: '', genre: 'Crime', rating: 8.8),
  Movie(title: 'The Crown', imageUrl: '', genre: 'Biography', rating: 8.6),
  Movie(title: 'Black Mirror', imageUrl: '', genre: 'Sci-Fi', rating: 8.8),
  Movie(title: 'Dark', imageUrl: '', genre: 'Mystery', rating: 8.8),
  Movie(title: 'Mindhunter', imageUrl: '', genre: 'Crime', rating: 8.6),
  Movie(title: 'The Umbrella Academy', imageUrl: '', genre: 'Action', rating: 7.9),
];

List<Movie> continueWatching = [
  Movie(title: 'Breaking Bad', imageUrl: '', genre: 'Crime', rating: 9.5),
  Movie(title: 'The Office', imageUrl: '', genre: 'Comedy', rating: 8.9),
  Movie(title: 'Friends', imageUrl: '', genre: 'Comedy', rating: 8.9),
  Movie(title: 'Sherlock', imageUrl: '', genre: 'Mystery', rating: 9.1),
  Movie(title: 'Game of Thrones', imageUrl: '', genre: 'Fantasy', rating: 9.3),
  Movie(title: 'Better Call Saul', imageUrl: '', genre: 'Crime', rating: 8.8),
];

List<Movie> forYou = [
  Movie(title: 'The Matrix', imageUrl: '', genre: 'Sci-Fi', rating: 8.7),
  Movie(title: 'Inception', imageUrl: '', genre: 'Sci-Fi', rating: 8.8),
  Movie(title: 'Interstellar', imageUrl: '', genre: 'Sci-Fi', rating: 8.6),
  Movie(title: 'The Dark Knight', imageUrl: '', genre: 'Action', rating: 9.0),
  Movie(title: 'Pulp Fiction', imageUrl: '', genre: 'Crime', rating: 8.9),
  Movie(title: 'Fight Club', imageUrl: '', genre: 'Drama', rating: 8.8),
];

List<Movie> actionMovies = [
  Movie(title: 'John Wick', imageUrl: '', genre: 'Action', rating: 7.4),
  Movie(title: 'Mad Max: Fury Road', imageUrl: '', genre: 'Action', rating: 8.1),
  Movie(title: 'Die Hard', imageUrl: '', genre: 'Action', rating: 8.2),
  Movie(title: 'Terminator 2', imageUrl: '', genre: 'Action', rating: 8.5),
  Movie(title: 'The Avengers', imageUrl: '', genre: 'Action', rating: 8.0),
  Movie(title: 'Mission Impossible', imageUrl: '', genre: 'Action', rating: 7.1),
];

List<Movie> comedyMovies = [
  Movie(title: 'The Hangover', imageUrl: '', genre: 'Comedy', rating: 7.7),
  Movie(title: 'Superbad', imageUrl: '', genre: 'Comedy', rating: 7.6),
  Movie(title: 'Anchorman', imageUrl: '', genre: 'Comedy', rating: 7.2),
  Movie(title: 'Step Brothers', imageUrl: '', genre: 'Comedy', rating: 6.9),
  Movie(title: 'Borat', imageUrl: '', genre: 'Comedy', rating: 7.3),
  Movie(title: 'Tropic Thunder', imageUrl: '', genre: 'Comedy', rating: 7.0),
];

List<Movie> documentaries = [
  Movie(title: 'Making a Murderer', imageUrl: '', genre: 'Documentary', rating: 8.6),
  Movie(title: 'Tiger King', imageUrl: '', genre: 'Documentary', rating: 7.5),
  Movie(title: 'Our Planet', imageUrl: '', genre: 'Documentary', rating: 9.3),
  Movie(title: 'The Social Dilemma', imageUrl: '', genre: 'Documentary', rating: 7.6),
  Movie(title: 'Free Solo', imageUrl: '', genre: 'Documentary', rating: 8.1),
  Movie(title: 'Won\'t You Be My Neighbor?', imageUrl: '', genre: 'Documentary', rating: 8.4),
];

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.videogame_asset_outlined,
              size: 80,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 20),
            const Text(
              'Games',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Coming soon...',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 80,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 20),
            const Text(
              'New & Hot',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Coming soon...',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.download_outlined,
              size: 80,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 20),
            const Text(
              'Downloads',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'No downloads yet',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_outlined,
              size: 80,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 20),
            const Text(
              'More',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Profile and settings coming soon...',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
