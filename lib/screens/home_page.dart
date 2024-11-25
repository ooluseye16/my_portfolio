import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/components/extensions.dart';
import 'package:my_portfolio/providers/theme_provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: isDarkMode ? 0.5 : 0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: 1.0,
                child: IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return RotationTransition(
                        turns: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: Icon(
                      isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      key: ValueKey<bool>(isDarkMode),
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  onPressed: () {
                    ref.read(themeProvider.notifier).toggleTheme();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define breakpoints
          final isDesktop = constraints.maxWidth > 1024;
          final isTablet =
              constraints.maxWidth > 600 && constraints.maxWidth <= 1024;
          //final isMobile = constraints.maxWidth <= 600;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // // Header section
              // Padding(
              //   padding: REdgeInsets.fromLTRB(16, 24, 48, 0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'OLUSEYE OBITOLA',
              //         style: TextStyle(
              //           fontSize: 28.sp,
              //           fontWeight: FontWeight.w700,
              //           color: Colors.black,
              //         ),
              //       ),
              //       if (isDesktop ||
              //           isTablet) // Only show navigation on desktop
              //         Row(
              //           children: [
              //             Text(
              //               'ABOUT',
              //               style: TextStyle(
              //                   fontSize: 24.sp,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black),
              //             ),
              //             30.horizontalSpace,
              //             Text(
              //               'PROJECTS',
              //               style: TextStyle(
              //                   fontSize: 24.sp,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black),
              //             ),
              //             30.horizontalSpace,
              //             Text(
              //               'CONTACT',
              //               style: TextStyle(
              //                   fontSize: 24.sp,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black),
              //             ),
              //           ],
              //         ),
              //       if (isMobile) // Only show navigation on mobile
              //         PopupMenuButton<String>(
              //           icon: const Icon(Icons.menu, color: Colors.black),
              //           color: Colors.white,
              //           onSelected: (value) {
              //             // Handle menu item selection
              //             switch (value) {
              //               case 'about':
              //                 // Navigate to about
              //                 break;
              //               case 'projects':
              //                 // Navigate to projects
              //                 break;
              //               case 'contact':
              //                 // Navigate to contact
              //                 break;
              //             }
              //           },
              //           itemBuilder: (BuildContext context) => [
              //             PopupMenuItem<String>(
              //               value: 'about',
              //               child: Text(
              //                 'About',
              //                 style: TextStyle(
              //                   fontSize: 16.sp,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ),
              //             PopupMenuItem<String>(
              //               value: 'projects',
              //               child: Text(
              //                 'Projects',
              //                 style: TextStyle(
              //                   fontSize: 16.sp,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ),
              //             PopupMenuItem<String>(
              //               value: 'contact',
              //               child: Text(
              //                 'Contact',
              //                 style: TextStyle(
              //                   fontSize: 16.sp,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //     ],
              //   ),
              // ),
              // 8.verticalSpace,
              // const Divider(
              //   color: Colors.black,
              //   thickness: 1,
              // ),
              // 32.verticalSpace,
              // Main content section
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isDesktop ? 64 : 16),
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left side - Description
                            Expanded(
                              flex: 1,
                              child: Center(
                                  child: _buildDescriptionSection(
                                      isDesktop, isTablet, context)),
                            ),
                            64.width,
                            // Right side - Projects
                            Expanded(
                              flex: 1,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    80.height,
                                    _buildProjectsSection(
                                        isDesktop, isTablet, context),
                                    120.height,
                                    _buildArticlesSection(
                                        isDesktop, isTablet, context),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDescriptionSection(
                                  isDesktop, isTablet, context),
                              120.height,
                              _buildProjectsSection(
                                  isDesktop, isTablet, context),
                              120.height,
                              _buildArticlesSection(
                                  isDesktop, isTablet, context),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDescriptionSection(
      bool isDesktop, bool isTablet, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          "Hi, I'm Oluseye 👋",
          style: TextStyle(
            fontSize: isDesktop
                ? 48
                : isTablet
                    ? 40
                    : 32,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        Text(
          "A Flutter Developer.",
          style: TextStyle(
            fontSize: isDesktop
                ? 48
                : isTablet
                    ? 40
                    : 32,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        8.height,
        Text(
          "I am a passionate mobile developer with a knack for creating user-friendly, efficient, and innovative applications. Currently, I'm focused on refining my skills and building apps that showcase creativity and functionality. Whether it's crafting dynamic interfaces or implementing clean, maintainable code, I'm dedicated to delivering excellence in every project. \n\nLet's collaborate and bring impactful ideas to life!",
          style: TextStyle(
            fontSize: isDesktop
                ? 18
                : isTablet
                    ? 14
                    : 12,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        64.height,
        _buildSocialLinks(isDesktop),
      ],
    );
  }

  Widget _buildProjectsSection(bool isDesktop, bool isTablet, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FEATURED PROJECTS ",
          style: TextStyle(
            fontSize: isDesktop
                ? 28
                : isTablet
                    ? 24
                    : 20,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        16.height,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: isDesktop ? 1 : 0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          width: double.infinity,
          child: Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.spaceBetween,
            children: [
              ProjectCard(
                isDesktop: isDesktop,
                isTablet: isTablet,
                projectName: 'Lorelink',
                projectDescription:
                    'A social media mobile app where users can create a story with each other. ',
                projectLink: 'https://github.com/ooluseye16/lorelink',
              ),
              ProjectCard(
                isDesktop: isDesktop,
                isTablet: isTablet,
                projectName: 'Free Rant',
                projectDescription:
                    'A mobile app where users can post their thoughts anonymously and it expires after 24 hours. Follows the design pattern of Whatsapp Status.',
                projectLink: 'https://github.com/ooluseye16/freerant',
              ),
              ProjectCard(
                isDesktop: isDesktop,
                isTablet: isTablet,
                projectName: 'Invoice Generator',
                projectDescription:
                    'A flutter app that generates invoices for a business. User enters the details of the product and the app generates an invoice in PDF format.',
                projectLink: 'https://github.com/ooluseye16/invoice_generator',
              ),
              ProjectCard(
                isDesktop: isDesktop,
                isTablet: isTablet,
                projectName: 'Point Tracker',
                projectDescription:
                    'A leaderboard mobile app where users can track their points. Uses Sqflite to store the data.',
                projectLink: 'https://github.com/ooluseye16/point_tracker',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(bool isDesktop) {
    return Wrap(
      runSpacing: 8,
      children: [
        _buildSocialLink(
          'Twitter',
          'https://twitter.com/oluseye_obitola',
          isDesktop,
        ),
        32.width,
        _buildSocialLink(
          'Github',
          'https://github.com/ooluseye16',
          isDesktop,
        ),
        32.width,
        _buildSocialLink(
          'LinkedIn',
          'https://www.linkedin.com/in/oluseye-obitola/',
          isDesktop,
        ),
        32.width,
        _buildSocialLink(
          'Email',
          'mailto:oluseyeobitola01@gmail.com',
          isDesktop,
        ),
      ],
    );
  }

  Widget _buildSocialLink(String text, String url, bool isDesktop) {
    return Link(
      uri: Uri.parse(url),
      builder: (context, followLink) => InkWell(
        onTap: () {
          launchUrl(Uri.parse(url));
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: isDesktop ? 18 : 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
            decoration: TextDecoration.underline,
            height: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildArticlesSection(
      bool isDesktop, bool isTablet, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ARTICLES ",
          style: TextStyle(
            fontSize: isDesktop
                ? 28
                : isTablet
                    ? 24
                    : 20,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        16.height,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(4),
          ),
          width: double.infinity,
          child: Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.spaceBetween,
            children: [
              ArticleCard(
                isDesktop: isDesktop,
                isTablet: isTablet,
                articleTitle: "Using PageView to display multiple StoryView.",
                articleLink:
                    "https://tirioh.hashnode.dev/using-pageview-to-display-multiple-storyview",
                articleDate: "November 7th, 2023",
                subtitle:
                    "An approach to showing multiple StoryView using Flutter",
              ),
              ArticleCard(
                isDesktop: isDesktop,
                isTablet: isTablet,
                articleTitle: "Where do I go from here?",
                articleDate: "July 20th, 2022",
                articleLink:
                    "https://tirioh.hashnode.dev/where-do-i-go-from-here",
                subtitle:
                    "A Roadmap to navigate your learning journey as a Flutter Developer.",
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.projectName,
    required this.projectDescription,
    required this.projectLink,
  });

  final bool isDesktop;
  final bool isTablet;
  final String projectName;
  final String projectDescription;
  final String projectLink;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isHovered ? 1.02 : 1.0),
        padding: EdgeInsets.symmetric(
          horizontal: widget.isDesktop ? 24 : 16,
          vertical: widget.isDesktop ? 32 : 24,
        ),
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).dividerColor,
              width: widget.isDesktop ? 1 : 0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        width: MediaQuery.of(context).size.width *
            (widget.isDesktop
                ? 0.42
                : widget.isTablet
                    ? 0.425
                    : 0.9),
        height: widget.isDesktop ? 300 : 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.projectName,
              style: TextStyle(
                fontSize: widget.isDesktop
                    ? 32
                    : widget.isTablet
                        ? 28
                        : 24,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            widget.isDesktop ? 16.height : 8.height,
            Text(
              widget.projectDescription,
              style: TextStyle(
                fontSize: widget.isDesktop ? 16 : 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const Spacer(),
            Link(
              uri: Uri.parse(widget.projectLink),
              builder: (context, followLink) => InkWell(
                onTap: () {
                  launchUrl(Uri.parse(widget.projectLink));
                },
                child: SvgPicture.asset(
                  'github'.toSvg,
                  height: widget.isDesktop ? 32 : 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleCard extends StatefulWidget {
  const ArticleCard({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.articleDate,
    required this.subtitle,
    required this.articleTitle,
    required this.articleLink,
  });

  final bool isDesktop;
  final bool isTablet;
  final String articleDate;
  final String subtitle;
  final String articleTitle;
  final String articleLink;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: Link(
        uri: Uri.parse(widget.articleLink),
        builder: (context, followLink) => InkWell(
          onTap: () {
            launchUrl(Uri.parse(widget.articleLink));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()..scale(isHovered ? 1.02 : 1.0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: widget.isDesktop ? 1 : 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            width: MediaQuery.of(context).size.width *
                (widget.isDesktop
                    ? 0.42
                    : widget.isTablet
                        ? 0.425
                        : 0.9),
            height: widget.isDesktop ? 300 : 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.articleDate,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.articleTitle,
                  style: TextStyle(
                    fontSize: widget.isDesktop ? 24 : 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                8.height,
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontSize: widget.isDesktop ? 16 : 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
