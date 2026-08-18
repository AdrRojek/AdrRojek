import 'package:flutter/material.dart';

class SiteLinks {
  static const github = 'https://github.com/AdrRojek';
  static const linkedin = 'https://www.linkedin.com/in/adrian-rojek-ar';
  static const email = 'adr.rojek@gmail.com';
  static const mailto = 'mailto:adr.rojek@gmail.com';
  static const phone = '+48 668 751 953';
  static const tel = 'tel:+48668751953';
}

class SkillItem {
  const SkillItem({required this.label, required this.iconAsset});
  final String label;
  final String iconAsset;
}

class InterestItem {
  const InterestItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.gifAsset,
  });
  final String title;
  final String description;
  final IconData icon;
  final String gifAsset;
}

class SoftSkillItem {
  const SoftSkillItem({
    required this.title,
    required this.icon,
    required this.level,
  });
  final String title;
  final IconData icon;
  final double level;
}

class CertificateItem {
  const CertificateItem({required this.title, required this.image});
  final String title;
  final String image;
}

class ProjectItem {
  const ProjectItem({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    required this.images,
    required this.previewImages,
    this.githubUrl,
    this.phoneLayout = false,
  });

  final int id;
  final String title;
  final String description;
  final List<String> technologies;
  final List<String> images;
  final List<String> previewImages;
  final String? githubUrl;
  final bool phoneLayout;
}

class SiteContent {
  static const name = 'Adrian Rojek';
  static const title = 'Computer Science student';
  static const about =
      'A passionate mobile app developer with experience in SwiftUI and Android Studio. Open to new challenges, I learn quickly and am eager to develop my skills. Creative and dedicated to every project, with a focus on delivering high-quality solutions.';

  static const education = [
    'University of Rzeszow (2022–)',
    'Electronics Schools Complex in Rzeszów (2018–2022)',
  ];

  static const experience = [
    'Mobile App Developer (Flutter) — DEVEJI (08.2025 – 10.2025)',
    'Web Developer — NEW PORTABLE DEVICES (05.2025 – 07.2025)',
    'Apprentice — G2A.COM R&D Center (06.2025 – 07.2025)',
    'Courier — Amazon (07.2024 – 09.2024)',
    'Courier — Amazon (07.2023 – 09.2023)',
    'Carpenter — ZAPEL PROBUD (04.2023 – 06.2023)',
    'Quality Controller — BorgWarner Rzeszow (06.2022 – 03.2023)',
    'Quality Controller — BorgWarner Rzeszow (07.2021 – 08.2021)',
    'Practices — Apollo Sp. z o.o. (06.2021)',
    'Practices — Apollo Sp. z o.o. (04.2020)',
  ];

  static const languages = [
    'Polish — Native',
    'English — C1',
    'German — B1',
  ];

  static const certificates = [
    CertificateItem(
      title: 'Mastering SwiftUI & SwiftUI for iOS development',
      image: 'assets/photos/certificate1.jpg',
    ),
    CertificateItem(
      title: 'Flutter Masterclass (from Novice to Ninja)',
      image: 'assets/photos/certificate2.jpg',
    ),
    CertificateItem(
      title: 'Java Masterclass 2025',
      image: 'assets/photos/certificate3.jpg',
    ),
  ];

  static const examEe08 = [
    'Installation and operation of computer systems, peripherals and networks',
    'Configuration of operating systems and application software',
    'Design and maintenance of local computer networks',
    'Network security and data protection',
  ];

  static const examEe09 = [
    'Programming and database design',
    'Creating web applications',
    'Database administration',
    'Web application testing and deployment',
  ];

  static const skills = [
    SkillItem(label: 'CSS3', iconAsset: 'assets/icons/css3.png'),
    SkillItem(label: 'HTML', iconAsset: 'assets/icons/html5.png'),
    SkillItem(label: 'PHP', iconAsset: 'assets/icons/php.png'),
    SkillItem(label: 'C++', iconAsset: 'assets/icons/cpp.png'),
    SkillItem(label: 'C#', iconAsset: 'assets/icons/csharp.png'),
    SkillItem(label: 'C', iconAsset: 'assets/icons/c.png'),
    SkillItem(label: 'Python', iconAsset: 'assets/icons/python.png'),
    SkillItem(label: 'Swift', iconAsset: 'assets/icons/swift.png'),
    SkillItem(label: 'GitHub', iconAsset: 'assets/icons/github.png'),
    SkillItem(label: 'Figma', iconAsset: 'assets/icons/figma.png'),
    SkillItem(label: 'MySQL', iconAsset: 'assets/icons/mysql.png'),
    SkillItem(label: 'SQLite', iconAsset: 'assets/icons/sqlite.png'),
  ];

  static const learning = [
    SkillItem(label: 'JavaScript', iconAsset: 'assets/icons/javascript.png'),
    SkillItem(label: 'Android Studio', iconAsset: 'assets/icons/androidstudio.png'),
    SkillItem(label: 'Laravel', iconAsset: 'assets/icons/laravel.png'),
    SkillItem(label: 'Docker', iconAsset: 'assets/icons/docker.png'),
    SkillItem(label: 'Figma', iconAsset: 'assets/icons/figma.png'),
    SkillItem(label: 'TensorFlow', iconAsset: 'assets/icons/tensorflow.png'),
    SkillItem(label: 'Kotlin', iconAsset: 'assets/icons/kotlin.png'),
    SkillItem(label: 'Java', iconAsset: 'assets/icons/java.png'),
    SkillItem(label: 'Gradle', iconAsset: 'assets/icons/gradle.png'),
  ];

  static const interests = [
    InterestItem(
      title: 'Automotive',
      description:
          'Enthusiast of motorsports, with a focus on Formula 1 and rally racing',
      icon: Icons.directions_car,
      gifAsset: 'assets/gifs/automotive.gif',
    ),
    InterestItem(
      title: 'Music',
      description: 'I relax and recharge by listening to my favorite music',
      icon: Icons.music_note,
      gifAsset: 'assets/gifs/music.gif',
    ),
    InterestItem(
      title: 'Cooking',
      description: 'Experimenting with new recipes and culinary techniques',
      icon: Icons.restaurant,
      gifAsset: 'assets/gifs/cooking.gif',
    ),
    InterestItem(
      title: 'Road trips',
      description: 'Discovering scenic routes and regions',
      icon: Icons.add_road,
      gifAsset: 'assets/gifs/roadtrips.gif',
    ),
  ];

  static const softSkills = [
    SoftSkillItem(
      title: 'Teamwork',
      icon: Icons.groups,
      level: 0.95,
    ),
    SoftSkillItem(
      title: 'Communication',
      icon: Icons.forum,
      level: 0.90,
    ),
    SoftSkillItem(
      title: 'Time Management',
      icon: Icons.checklist,
      level: 0.85,
    ),
    SoftSkillItem(
      title: 'Creativity',
      icon: Icons.lightbulb_outline,
      level: 0.92,
    ),
    SoftSkillItem(
      title: 'Problem-Solving and Critical Thinking',
      icon: Icons.extension,
      level: 0.92,
    ),
    SoftSkillItem(
      title: 'Fast learning',
      icon: Icons.menu_book,
      level: 0.92,
    ),
    SoftSkillItem(
      title: 'Patience',
      icon: Icons.schedule,
      level: 0.92,
    ),
  ];

  static const projects = [
    ProjectItem(
      id: 1,
      title: 'Water Reminder App',
      phoneLayout: true,
      description:
          'Water Tracker is an app designed to help users monitor their daily water intake, aiming for a goal of 4000 ml per day. It features an intuitive interface with a progress widget, options to add/subtract water, integration with a "boiler" (a simulated water reservoir), and reminders to stay hydrated. Users can track their history, reset data, and monitor their progress throughout the day.',
      technologies: [
        'SwiftUI',
        'SwiftData',
        'UserNotifications',
        'SwiftUIGIF',
        'Core Data',
        'iOS Native Components',
      ],
      previewImages: [
        'assets/photos/waterReminder1.png',
        'assets/photos/waterReminder3.png',
        'assets/photos/waterReminder2.png',
      ],
      images: [
        'assets/photos/waterReminder1.png',
        'assets/photos/waterReminder2.png',
        'assets/photos/waterReminder3.png',
      ],
      githubUrl: 'https://github.com/AdrRojek/WaterReminder',
    ),
    ProjectItem(
      id: 2,
      title: 'Lotto Results App',
      phoneLayout: true,
      description:
          'Lotto Tracker is an app for lottery fans that lets you save your own draws (6 numbers 1–49) with timestamps and a Plus option, visually track matches in the main draw and Plus version, and instantly access official results through a built-in browser — all in an intuitive interface, perfect for planning bets and analyzing luck in real time!',
      technologies: [
        'SwiftUI',
        'SwiftData',
        'WebKit',
        'Foundation',
        'Model-View-ViewModel (MVVM)',
        'iOS Native Components',
      ],
      previewImages: [
        'assets/photos/Lotto1.png',
        'assets/photos/Lotto4.png',
        'assets/photos/Lotto3.png',
      ],
      images: [
        'assets/photos/Lotto1.png',
        'assets/photos/Lotto2.png',
        'assets/photos/Lotto3.png',
        'assets/photos/Lotto4.png',
      ],
      githubUrl: 'https://github.com/AdrRojek/Lotto-Results-App',
    ),
    ProjectItem(
      id: 3,
      title: 'FitnessApp',
      phoneLayout: true,
      description:
          'FitnessApp is a mobile app designed to help users maintain their health and fitness. It tracks daily physical activity using a step counter and displays weekly statistics through clear charts. Users can monitor their weight, add photos (from the gallery or camera), and use maps to record routes and analyze activity history. The app also includes login, registration, and profile management features, offering a personalized experience and motivation to achieve fitness goals.',
      technologies: [
        'Kotlin',
        'Android SDK',
        'SQLite',
        'MPAndroidChart',
        'SensorManager',
        'SharedPreferences',
        'File API',
      ],
      previewImages: [
        'assets/photos/fitnessapp3.jpg',
        'assets/photos/fitnessapp2.jpg',
        'assets/photos/fitnessapp7.jpg',
      ],
      images: [
        'assets/photos/fitnessapp1.jpg',
        'assets/photos/fitnessapp2.jpg',
        'assets/photos/fitnessapp3.jpg',
        'assets/photos/fitnessapp4.jpg',
        'assets/photos/fitnessapp5.jpg',
        'assets/photos/fitnessapp6.jpg',
        'assets/photos/fitnessapp7.jpg',
        'assets/photos/fitnessapp8.jpg',
      ],
    ),
    ProjectItem(
      id: 4,
      title: 'Community Forum using Oracle database',
      description:
          'The Community Forum project is an online platform that enables users to connect, share information, collaborate, and express opinions through surveys. The platform offers functionalities such as creating user profiles, publishing posts and comments, joining thematic groups, creating surveys, and managing friends. The system is designed with intuitive usability and efficient data management in mind, utilizing a relational Oracle database to store information about users, posts, groups, and surveys.',
      technologies: ['PHP', 'Oracle', 'Git'],
      previewImages: ['assets/photos/Oracle4.png'],
      images: [
        'assets/photos/Oracle1.png',
        'assets/photos/Oracle2.png',
        'assets/photos/Oracle3.png',
        'assets/photos/Oracle4.png',
        'assets/photos/Oracle5.png',
        'assets/photos/Oracle6.png',
        'assets/photos/Oracle7.png',
      ],
      githubUrl: 'https://github.com/AdrRojek/Community-Forum',
    ),
    ProjectItem(
      id: 5,
      title: 'Bus Timetable Information',
      description:
          'Bus-Info is a modern IT system designed to streamline public transport management. It offers comprehensive tools for administrators, drivers, and passengers, simplifying route planning, task assignment, vehicle monitoring, and access to schedules. With an intuitive interface, Bus-Info provides easy access to all system features. Administrators can manage users, routes, stops, and assign routes to drivers. Drivers access their work schedules and route details, while passengers view real-time bus locations and up-to-date timetables.',
      technologies: ['PHP', 'Laravel', 'Bootstrap', 'XAMPP', 'Composer', 'Git'],
      previewImages: ['assets/photos/larawel16.png'],
      images: [
        'assets/photos/larawel1.png',
        'assets/photos/larawel2.png',
        'assets/photos/larawel3.png',
        'assets/photos/larawel4.png',
        'assets/photos/larawel5.png',
        'assets/photos/larawel6.png',
        'assets/photos/larawel7.png',
        'assets/photos/larawel8.png',
        'assets/photos/larawel9.png',
        'assets/photos/larawel10.png',
        'assets/photos/larawel11.png',
        'assets/photos/larawel12.png',
        'assets/photos/larawel13.png',
        'assets/photos/larawel14.png',
        'assets/photos/larawel15.png',
        'assets/photos/larawel16.png',
      ],
      githubUrl:
          'https://github.com/AdrRojek/Bus-Timetable-Information-System',
    ),
    ProjectItem(
      id: 6,
      title: 'Car Mechanic Workshop',
      description:
          'The project involves creating a comprehensive system for managing a vehicle repair shop. The system organizes information about vehicles, repairs, and mechanics, enabling efficient customer service and better management of the workshop\'s operations. The main functionalities include CRUD operations on data related to mechanics, repairs, and vehicles, as well as input data validation. The system uses a relational database (MySQL) for data storage, and the user interface is designed to be intuitive and responsive.',
      technologies: ['Java', 'MySQL', 'Git'],
      previewImages: ['assets/photos/zmp1.png'],
      images: [
        'assets/photos/zmp1.png',
        'assets/photos/zmp2.png',
        'assets/photos/zmp3.png',
        'assets/photos/zmp4.png',
        'assets/photos/zmp5.png',
        'assets/photos/zmp6.png',
        'assets/photos/zmp7.png',
        'assets/photos/zmp8.png',
        'assets/photos/zmp9.png',
      ],
      githubUrl: 'https://github.com/AdrRojek/Car-Mechanic-Workshop',
    ),
  ];
}
