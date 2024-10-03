import 'package:flutter/material.dart';

class ReportsDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF0B0F19), // Background color same as in the image
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F19),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Premium Reports',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Browse our Premium Reports',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.white70),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search Marriage, career, etc...',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white70),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.blue,
                        indicatorWeight:
                            4.0, // Increased thickness of the blue line below the selected tab
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        tabs: [
                          Tab(
                            child: Container(
                              height: 50, // Increased height of the tab
                              alignment: Alignment
                                  .center, // Centering text within the tab
                              child: const Text(
                                'Marriage',
                                style: TextStyle(
                                    fontSize: 18), // Increased text size
                              ),
                            ),
                          ),
                          SizedBox(width: 16), // Space between the tabs
                          Tab(
                            child: Container(
                              height: 50, // Increased height of the tab
                              alignment: Alignment
                                  .center, // Centering text within the tab
                              child: const Text(
                                'Career',
                                style: TextStyle(
                                    fontSize: 18), // Increased text size
                              ),
                            ),
                          ),
                          SizedBox(width: 16), // Space between the tabs
                          Tab(
                            child: Container(
                              height: 50, // Increased height of the tab
                              alignment: Alignment
                                  .center, // Centering text within the tab
                              child: const Text(
                                'Family',
                                style: TextStyle(
                                    fontSize: 18), // Increased text size
                              ),
                            ),
                          ),
                          SizedBox(width: 16), // Space between the tabs
                          Tab(
                            child: Container(
                              height: 50, // Increased height of the tab
                              alignment: Alignment
                                  .center, // Centering text within the tab
                              child: const Text(
                                'Health',
                                style: TextStyle(
                                    fontSize: 18), // Increased text size
                              ),
                            ),
                          ),
                        ],
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelPadding: EdgeInsets
                            .zero, // Remove any padding on the sides of tabs
                        indicatorPadding: EdgeInsets
                            .zero, // Remove padding around the indicator
                      ),
                    ),
                    const SizedBox(height: 38),
                    Container(
                      height: MediaQuery.of(context).size.height *
                          0.5, // Adjust this based on your needs
                      child: TabBarView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Marriage',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 24),
                              buildMarriageList(),
                            ],
                          ),
                          const Center(
                              child: Text('Career Reports',
                                  style: TextStyle(color: Colors.white))),
                          const Center(
                              child: Text('Family Reports',
                                  style: TextStyle(color: Colors.white))),
                          const Center(
                              child: Text('Health Reports',
                                  style: TextStyle(color: Colors.white))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 38),
                    Container(
                      height: MediaQuery.of(context).size.height *
                          0.5, // Adjust this based on your needs
                      child: TabBarView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Career',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 28),
                              buildMarriageList(),
                            ],
                          ),
                          const Center(
                              child: Text('Career Reports',
                                  style: TextStyle(color: Colors.white))),
                          const Center(
                              child: Text('Family Reports',
                                  style: TextStyle(color: Colors.white))),
                          const Center(
                              child: Text('Health Reports',
                                  style: TextStyle(color: Colors.white))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Horizontal list for Marriage section
  Widget buildMarriageList() {
    List<Map<String, dynamic>> marriageCourses = [
      {
        'title': 'Marriage Timing Prediction',
        'price': '₹999.00',
        'image': 'assets/images/marriage.png',
        'rating': 4.9
      },
      {
        'title': 'Marriage Compatibility Report',
        'price': '₹999.00',
        'image': 'assets/images/marriage.png',
        'rating': 4.8
      },
      {
        'title': 'Marriage Success Formula',
        'price': '₹1299.00',
        'image': 'assets/images/marriage.png',
        'rating': 4.7
      },
    ];

    return Expanded(
      child: Container(
        height: 220, // Increased the height for a larger display
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: marriageCourses.length,
          itemBuilder: (context, index) {
            return buildCourseCard(
              marriageCourses[index]['title'],
              marriageCourses[index]['price'],
              marriageCourses[index]['image'],
              marriageCourses[index]['rating'],
            );
          },
        ),
      ),
    );
  }

  // Course card widget
  Widget buildCourseCard(
      String title, String price, String imagePath, double rating) {
    return Container(
      width: 280, // Increased the width for a larger card
      margin: const EdgeInsets.only(right: 16), // Spacing between cards
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2230),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  12), // Apply circular border to the image
              child: Image.asset(
                imagePath,
                width: 260, // Increased image size
                height: 140,
                fit: BoxFit.cover, // Ensures image scales properly
              ),
            ),
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Space between price and rating
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20, // Increased font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_border, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${rating.toStringAsFixed(1)}/5', // Display rating out of 5
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20, // Increased font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
              height: 12), // Add some spacing between price/rating and title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          const Text(
            'Discover the perfect time for your marriage through the guidance of Vedic Astrology and an advanced AI-ML model',
            style: TextStyle(
              color: Color.fromARGB(117, 255, 255, 255),
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 18), // Spacing before buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  width: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      // View button action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(43, 33, 149, 243),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          // Add a colored border
                          color: Colors.white, // Set the color of the border
                          width: 2, // Set the width of the border
                        ), // Reduce the border radius
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize
                          .min, // Ensures button is only as wide as content
                      children: [
                        Icon(Icons.visibility, size: 16), // Icon
                        SizedBox(
                            width:
                                8), // Add some space between the icon and text
                        Text('View'), // Text
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Purchase button action
                  },
                  label: const Text('Purchase'),
                  icon: const Icon(Icons.shopping_cart, size: 16),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCareerList() {
    List<Map<String, dynamic>> marriageCourses = [
      {
        'title': 'Marriage Timing Prediction',
        'price': '₹999.00',
        'image': 'assets/images/marriage.png',
        'rating': 4.5
      },
      {
        'title': 'Marriage Compatibility Report',
        'price': '₹999.00',
        'image': 'assets/images/marriage.png',
        'rating': 4.8
      },
      {
        'title': 'Marriage Success Formula',
        'price': '₹1299.00',
        'image': 'assets/images/marriage.png',
        'rating': 4.7
      },
    ];

    return Expanded(
      child: Container(
        height: 220, // Increased the height for a larger display
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: marriageCourses.length,
          itemBuilder: (context, index) {
            return buildCourseCard(
              marriageCourses[index]['title'],
              marriageCourses[index]['price'],
              marriageCourses[index]['image'],
              marriageCourses[index]['rating'],
            );
          },
        ),
      ),
    );
  }

  // Course card widget
  Widget buildCareerCard(
      String title, String price, String imagePath, double rating) {
    return Container(
      width: 280, // Increased the width for a larger card
      margin: const EdgeInsets.only(right: 16), // Spacing between cards
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2230),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Image.asset(
            imagePath,
            width: 260, // Increased image size
            height: 140,
            fit: BoxFit.cover, // Ensures image scales properly
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Space between price and rating
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20, // Increased font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_border, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${rating.toStringAsFixed(1)}/5', // Display rating out of 5
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20, // Increased font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
              height: 8), // Add some spacing between price/rating and title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Discover the perfect time for your marriage through the guidance of Vedic Astrology and an advanced AI-ML model',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 18), // Spacing before buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // View button action
                  },
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text('View'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Purchase button action
                  },
                  icon: const Icon(Icons.shopping_cart, size: 16),
                  label: const Text('Purchase'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
