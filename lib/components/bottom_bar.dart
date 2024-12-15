import 'package:flutter/material.dart';

class DockingBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onSelect;

  const DockingBar({
    Key? key,
    required this.currentIndex,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<DockingBar> createState() => _DockingBarState();
}

class _DockingBarState extends State<DockingBar> {
  int activeIndex = 0;

  final List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.add,
    Icons.notifications,
    Icons.person,
  ];

  @override
  void initState() {
    super.initState();
    activeIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Reduced padding around the docking bar
      child: Container(
        height: 55, // Reduced height for a more compact look
        width: MediaQuery.of(context).size.width * 0.75, // Reduced width to 75% of screen width
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent,Colors.green], // Smooth gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20), // Slightly reduced border radius for a tighter feel
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 3,
              blurRadius: 8,
              offset: Offset(0, 4), // Adds subtle depth to the container
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space icons evenly
          children: List.generate(icons.length, (i) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = i;
                });
                widget.onSelect(i);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 40, // Further reduced width for each icon
                height: 40, // Further reduced height for each icon
                decoration: BoxDecoration(
                  color: activeIndex == i
                      ? Colors.white.withOpacity(0.8) // Highlight active icon with white background
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12), // Reduced border radius for a tighter look
                  boxShadow: activeIndex == i
                      ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ]
                      : [],
                ),
                child: Center(
                  child: Icon(
                    icons[i],
                    size: 20, // Reduced icon size for a more compact design
                    color: activeIndex == i ? Colors.black : Colors.white,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
