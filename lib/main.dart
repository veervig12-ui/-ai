import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const PatternHunterApp());
}

class PatternHunterApp extends StatelessWidget {
  const PatternHunterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PatternHunter v2.4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0C10),
        primaryColor: const Color(0xFF00F0FF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00F0FF),
          secondary: Color(0xFF39FF14),
          surface: Color(0xFF141822),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Market Prices States
  double btcPrice = 68245.50;
  double ethPrice = 3512.20;
  double solPrice = 148.75;
  int fearGreed = 74;

  Timer? _timer;
  final Random _random = Random();

  // User Authentication Simulation
  bool isLoggedIn = false;
  String userName = "Guest Hunter";

  @override
  void initState() {
    super.initState();
    // Live Market Simulation (Changes prices every 3 seconds)
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        btcPrice += (_random.nextDouble() - 0.49) * 45;
        ethPrice += (_random.nextDouble() - 0.49) * 3.5;
        solPrice += (_random.nextDouble() - 0.51) * 0.25;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Sound Effect Function
  void _playClickSound() {
    SystemSound.play(SystemSoundType.click);
  }

  // Auth Dialog
  void _showAuthModal() {
    _playClickSound();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF12141C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'SIGN IN TO CORE ENGINE',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00F0FF),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F2833),
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Color(0xFF00F0FF), width: 0.5),
                ),
                icon: const Icon(Icons.security, color: Color(0xFF39FF14)),
                label: const Text('Simulate Secure Google Login'),
                onPressed: () {
                  setState(() {
                    isLoggedIn = true;
                    userName = "Alex Sterling";
                  });
                  Navigator.pop(context);
                  _playClickSound();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Access Granted. Welcome Vanguard!')),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildDashboard(),
      _buildCommunityTab(),
      _buildAiAssistant(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF141822),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF00F0FF).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.developer_board, color: Color(0xFF00F0FF), size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'PATTERNHUNTER',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
                Text(
                  'v2.4 Core Engine',
                  style: TextStyle(fontSize: 9, color: Colors.cyanAccent, fontFamily: 'monospace'),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            key: const ValueKey('auth_section'),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: isLoggedIn ? const Color(0xFF39FF14) : const Color(0xFF00F0FF)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: isLoggedIn ? () {
                setState(() {
                  isLoggedIn = false;
                  userName = "Guest Hunter";
                });
              } : _showAuthModal,
              icon: Icon(
                isLoggedIn ? Icons.verified_user : Icons.account_circle,
                size: 16,
                color: isLoggedIn ? const Color(0xFF39FF14) : const Color(0xFF00F0FF),
              ),
              label: Text(
                isLoggedIn ? 'Sign Out' : 'Sign In',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF141822),
        selectedItemColor: const Color(0xFF00F0FF),
        unselectedItemColor: Colors.white30,
        onTap: (index) {
          _playClickSound();
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'AI Analyst'),
        ],
      ),
    );
  }

  // 1. Dashboard Widget
  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting & Balance Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2833).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome back, $userName', style: const TextStyle(color: Colors.white60, fontSize: 13)),
                const SizedBox(height: 8),
                const Text('\$14,750.85', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1)),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.arrow_upward, color: Color(0xFF39FF14), size: 14),
                    Text(' +\$385.40 (Today)', style: TextStyle(color: Color(0xFF39FF14), fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Live Prices Ticker
          const Text('LIVE ASSETS TICKER', style: TextStyle(fontFamily: 'monospace', color: Colors.white30, fontSize: 11)),
          const SizedBox(height: 8),
          _buildCryptoRow('Bitcoin', 'BTC', btcPrice, true),
          _buildCryptoRow('Ethereum', 'ETH', ethPrice, true),
          _buildCryptoRow('Solana', 'SOL', solPrice, false),

          const SizedBox(height: 20),
          // Fear & Greed Gauge Simulation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF141822),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF00F0FF).withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Fear & Greed Index', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Text('Status: Greed', style: TextStyle(color: const Color(0xFF39FF14).withValues(alpha: 0.9), fontSize: 12)),
                  ],
                ),
                Text('$fearGreed', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF39FF14))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCryptoRow(String name, String symbol, double price, bool isUp) {
    return Card(
      color: const Color(0xFF12141C),
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: Colors.white12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF1F2833),
          child: Text(symbol[0], style: const TextStyle(color: Color(0xFF00F0FF))),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(symbol, style: const TextStyle(color: Colors.white30, fontSize: 12)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$${price.toStringAsFixed(2)}', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
            Text(isUp ? '+2.4%' : '-1.1%', style: TextStyle(color: isUp ? const Color(0xFF39FF14) : Colors.redAccent, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  // 2. Community Tab Widget
  Widget _buildCommunityTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Create Post Box
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF141822), borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              const CircleAvatar(child: Text('🧠')),
              const SizedBox(width: 12),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: "Share a chart pattern breakout...", border: InputBorder.none),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFF00F0FF)),
                onPressed: () {
                  _playClickSound();
                },
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildPostCard('CryptoViper', 'Pro Analyst', 'Just spotted an incredible Double Bottom pattern forming on the BTC 4H chart. Support held brilliantly at \$67.5k. 📈🔥'),
        _buildPostCard('PatternNinja', 'Wave Expert', 'Ethereum Falling Wedge is reaching its apex. Historically, this has an 82% win rate on high volume.'),
      ],
    );
  }

  Widget _buildPostCard(String author, String role, String content) {
    return Card(
      color: const Color(0xFF12141C),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundColor: Colors.white10, child: Icon(Icons.person)),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(author, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(role, style: const TextStyle(color: Colors.cyanAccent, fontSize: 10)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 12),
            Text(content, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(icon: const Icon(Icons.thumb_up_outlined, size: 16), onPressed: _playClickSound),
                const Text('42', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 16),
                IconButton(icon: const Icon(Icons.comment_outlined, size: 16), onPressed: _playClickSound),
              ],
            )
          ],
        ),
      ),
    );
  }

  // 3. AI Assistant Tab Widget
  Widget _buildAiAssistant() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF12141C), borderRadius: BorderRadius.circular(16)),
              child: ListView(
                children: const [
                  Text(
                    'AI ASSISTANT SYSTEM:',
                    style: TextStyle(fontFamily: 'monospace', color: Colors.cyanAccent, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Hello! I am your AI Pattern Analyst. Ask me anything about patterns (e.g., "Explain Double Bottom").',
                    style: TextStyle(color: Colors.white70),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ask Gemini AI Analyst...',
                    filled: true,
                    fillColor: Color(0xFF141822),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: const Color(0xFF00F0FF),
                child: IconButton(
                  icon: const Icon(Icons.bolt, color: Colors.black),
                  onPressed: _playClickSound,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
