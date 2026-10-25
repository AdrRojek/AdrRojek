import 'package:flutter/material.dart';

class SiteLinks {
  static const github = 'https://github.com/AdrRojek';
  static const linkedin = 'https://www.linkedin.com/in/adrian-rojek-ar';
  static const email = 'adr.rojek@gmail.com';
  static const mailto =
      'mailto:adr.rojek@gmail.com?subject=Job%20/%20internship%20/%20praktyki%20%E2%80%94%20Adrian%20Rojek';
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
  const CertificateItem({required this.title, this.image});
  final String title;
  final String? image;
}

class RoleItem {
  const RoleItem({
    required this.role,
    required this.company,
    required this.dates,
    this.bullets = const [],
    this.featured = false,
  });

  final String role;
  final String company;
  final String dates;
  final List<String> bullets;
  final bool featured;
}

class ProjectItem {
  const ProjectItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.summaryPl,
    required this.description,
    required this.technologies,
    required this.images,
    required this.previewImages,
    this.githubUrl,
    this.phoneLayout = false,
  });

  final int id;
  final String title;
  final String summary;
  final String summaryPl;
  final String description;
  final List<String> technologies;
  final List<String> images;
  final List<String> previewImages;
  final String? githubUrl;
  final bool phoneLayout;
}

class SiteContent {
  static const name = 'Adrian Rojek';
  static const title = 'Junior Mobile Developer';
  static const titlePl = 'Junior Mobile Developer';
  static const location = 'Boguchwała / remote · Rzeszów, Poland';
  static const stack = 'Flutter  ·  SwiftUI  ·  Kotlin  ·  Python';
  static const about =
      'Building mobile & cross-platform apps (SwiftUI, Flutter/Bloc + Firebase) and Python + LLM tools (RAG / fine-tuning). Shipped B2B apps at DEVEJI to Google Play & App Store. Open to junior roles, internships and apprenticeships.';
  static const pitchEn =
      'M.Sc. CS student (B.Eng. done). Flutter (Bloc) + Firebase, SwiftUI, Kotlin, and Python + LLM (RAG / fine-tuning). Shipped B2B apps at DEVEJI to the stores; G2A R&D internship with Python. Looking for junior / internship roles.';
  static const pitchPl =
      'Student mgr informatyki (inż. ukończony). Flutter (Bloc) + Firebase, SwiftUI, Kotlin oraz Python + LLM (RAG / fine-tuning). W DEVEJI publikowałem B2B w Google Play / App Store; praktyki R&D w G2A (Python). Szukam juniora, stażu lub praktyk.';

  static const aiAtWorkEn =
      'Cursor · ChatGPT — scaffolding, code review and faster debugging. I always verify and own the code before merge.';
  static const aiAtWorkPl =
      'Cursor · ChatGPT — scaffolding, code review i szybsze debugowanie. Zawsze weryfikuję i rozumiem kod przed merge.';

  static const education = [
    'M.Sc. Computer Science — University of Rzeszów (02.2026 – present)',
    'B.Eng. Computer Science (Internet Applications) — University of Rzeszów (10.2022 – 02.2026)',
    'IT Technician — Electronics Schools Complex, Rzeszów (09.2018 – 04.2022)',
  ];

  static const experience = [
    RoleItem(
      role: 'Mobile App Developer (Flutter)',
      company: 'DEVEJI',
      dates: '08.2025 – 10.2025',
      featured: true,
      bullets: [
        'B2B iOS/Android apps in Flutter + Dart (Bloc) and related product sites',
        'Firebase (Firestore, Auth, Cloud Functions), API integrations',
        'Published to Google Play & App Store; shared CI/CD ownership',
      ],
    ),
    RoleItem(
      role: 'Web Developer',
      company: 'NEW PORTABLE DEVICES',
      dates: '05.2025 – 07.2025',
      featured: true,
      bullets: [
        'Responsive company/product sites, SEO and performance',
        'Content updates and feature work in a small team',
      ],
    ),
    RoleItem(
      role: 'R&D Apprentice',
      company: 'G2A.COM R&D Center',
      dates: '06.2025 – 07.2025',
      featured: true,
      bullets: [
        'Testing (Python, PowerShell, Bash), error analysis, documentation',
        'Supported production updates and system monitoring',
      ],
    ),
    RoleItem(
      role: 'Courier',
      company: 'Amazon',
      dates: '07.2024 – 09.2024',
    ),
    RoleItem(
      role: 'Courier',
      company: 'Amazon',
      dates: '07.2023 – 09.2023',
    ),
    RoleItem(
      role: 'Carpenter',
      company: 'ZAPEL PROBUD',
      dates: '04.2023 – 06.2023',
    ),
    RoleItem(
      role: 'Quality Controller',
      company: 'BorgWarner Rzeszow',
      dates: '06.2022 – 03.2023',
    ),
    RoleItem(
      role: 'Quality Controller',
      company: 'BorgWarner Rzeszow',
      dates: '07.2021 – 08.2021',
    ),
    RoleItem(
      role: 'Practices',
      company: 'Apollo Sp. z o.o.',
      dates: '06.2021',
    ),
    RoleItem(
      role: 'Practices',
      company: 'Apollo Sp. z o.o.',
      dates: '04.2020',
    ),
  ];

  static const languages = [
    'Polish — Native',
    'English — C2 (EF SET 82/100 · R C2 · L C2 · W C1 · S C2)',
    'German — B1',
  ];

  static const certificates = [
    CertificateItem(
      title: 'EF SET English C2 (2026) — 82/100',
    ),
    CertificateItem(
      title: 'Mastering SwiftUI & SwiftData for iOS development',
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
    SkillItem(label: 'Flutter', iconAsset: 'assets/icons/flutter.png'),
    SkillItem(label: 'Swift', iconAsset: 'assets/icons/swift.png'),
    SkillItem(label: 'Kotlin', iconAsset: 'assets/icons/kotlin.png'),
    SkillItem(label: 'Python', iconAsset: 'assets/icons/python.png'),
    SkillItem(label: 'Java', iconAsset: 'assets/icons/java.png'),
    SkillItem(label: 'PHP', iconAsset: 'assets/icons/php.png'),
    SkillItem(label: 'Laravel', iconAsset: 'assets/icons/laravel.png'),
    SkillItem(label: 'C++', iconAsset: 'assets/icons/cpp.png'),
    SkillItem(label: 'C#', iconAsset: 'assets/icons/csharp.png'),
    SkillItem(label: 'C', iconAsset: 'assets/icons/c.png'),
    SkillItem(label: 'MySQL', iconAsset: 'assets/icons/mysql.png'),
    SkillItem(label: 'SQLite', iconAsset: 'assets/icons/sqlite.png'),
    SkillItem(label: 'GitHub', iconAsset: 'assets/icons/github.png'),
    SkillItem(label: 'Android Studio', iconAsset: 'assets/icons/androidstudio.png'),
  ];

  static const learning = [
    SkillItem(label: 'TensorFlow', iconAsset: 'assets/icons/tensorflow.png'),
    SkillItem(label: 'Docker', iconAsset: 'assets/icons/docker.png'),
    SkillItem(label: 'JavaScript', iconAsset: 'assets/icons/javascript.png'),
    SkillItem(label: 'HTML', iconAsset: 'assets/icons/html5.png'),
    SkillItem(label: 'CSS3', iconAsset: 'assets/icons/css3.png'),
    SkillItem(label: 'Figma', iconAsset: 'assets/icons/figma.png'),
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
      title: 'Fast learning',
      icon: Icons.menu_book,
      level: 0.95,
    ),
    SoftSkillItem(
      title: 'Teamwork',
      icon: Icons.groups,
      level: 0.95,
    ),
    SoftSkillItem(
      title: 'Attention to detail',
      icon: Icons.center_focus_strong,
      level: 0.92,
    ),
    SoftSkillItem(
      title: 'Punctuality',
      icon: Icons.schedule,
      level: 0.93,
    ),
    SoftSkillItem(
      title: 'Problem-Solving',
      icon: Icons.extension,
      level: 0.92,
    ),
    SoftSkillItem(
      title: 'Communication',
      icon: Icons.forum,
      level: 0.90,
    ),
  ];

  static const projects = [
    ProjectItem(
      id: 1,
      title: 'Water Reminder App',
      phoneLayout: true,
      summary: 'iOS hydration tracker with reminders, history, and a daily 4000 ml goal.',
      summaryPl: 'Aplikacja iOS do nawodnienia: przypomnienia, historia, cel 4000 ml dziennie.',
      description:
          'Water Tracker helps users monitor daily water intake toward a 4000 ml goal. Progress widget, add/subtract logging, local reminders, history, and smooth animations — solid native iOS UI + persistence habits.',
      technologies: [
        'SwiftUI',
        'Core Data',
        'UserNotifications',
        'SwiftUIGIF',
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
      title: 'DocQA — RAG Chatbot',
      summary: 'Python RAG chatbot over your PDFs/Markdown with source citations.',
      summaryPl: 'Chatbot RAG w Pythonie nad PDF/Markdown z cytowaniem źródeł.',
      description:
          'Q&A over your own documents: chunking, embeddings, vector retrieval (FAISS), and answers with source citations. FastAPI backend; LangChain orchestration; OpenAI (or compatible) embeddings/LLM.',
      technologies: [
        'Python',
        'LangChain',
        'OpenAI API',
        'FAISS',
        'FastAPI',
        'LLM / RAG',
      ],
      previewImages: [],
      images: [],
      githubUrl: 'https://github.com/AdrRojek/DocQA-RAG',
    ),
    ProjectItem(
      id: 3,
      title: 'Intent Classifier (fine-tune)',
      summary: 'Fine-tuned DistilBERT for ticket intent classification + ONNX export.',
      summaryPl: 'Fine-tuning DistilBERT do klasyfikacji intencji ticketów + eksport ONNX.',
      description:
          'Fine-tuning a small transformer (DistilBERT) for support-ticket intent classification. Evaluation with F1 metrics, ONNX export for lighter inference, and a simple CLI for batch prediction.',
      technologies: [
        'Python',
        'Hugging Face',
        'Transformers',
        'PyTorch',
        'scikit-learn',
        'ONNX',
      ],
      previewImages: [],
      images: [],
      githubUrl: 'https://github.com/AdrRojek/IntentClassifier-LLM',
    ),
    ProjectItem(
      id: 4,
      title: 'Prompt Playground',
      summary: 'Streamlit sandbox to compare prompts, temperature, and LLM responses.',
      summaryPl: 'Sandbox Streamlit: prompły, temperatura i porównanie odpowiedzi LLM.',
      description:
          'Sandbox for testing system/user prompts against OpenAI or a local LLM. Adjust temperature, compare responses side-by-side, and keep a session history log for iteration.',
      technologies: [
        'Python',
        'Streamlit',
        'OpenAI API',
        'Local LLM',
      ],
      previewImages: [],
      images: [],
      githubUrl: 'https://github.com/AdrRojek/PromptPlayground',
    ),
    ProjectItem(
      id: 5,
      title: 'FitnessApp',
      phoneLayout: true,
      summary: 'Mobile fitness app: steps, charts, weight photos, maps, and accounts.',
      summaryPl: 'Aplikacja fitness: kroki, wykresy, waga, mapy i konta użytkowników.',
      description:
          'FitnessApp helps users maintain health and fitness. Step counter, weekly charts, weight tracking with photos, maps for routes, plus login/registration and profile management.',
      technologies: [
        'Kotlin',
        'Android SDK',
        'SQLite',
        'MPAndroidChart',
        'SensorManager',
        'SharedPreferences',
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
      id: 6,
      title: 'Fruit & Vegetable Tracker',
      summary: 'Flutter offline nutrition tracker with on-device ML product scanning.',
      summaryPl: 'Flutter: offline tracker spożycia ze skanowaniem produktów (ML).',
      description:
          'Cross-platform offline tracker for daily fruit & vegetable intake. ML-based product scanning, nutritional analysis, history, favorites, and a shopping planner — all stored locally in SQLite (no cloud).',
      technologies: [
        'Flutter',
        'Provider',
        'SQLite',
        'On-device ML',
      ],
      previewImages: [],
      images: [],
    ),
    ProjectItem(
      id: 7,
      title: 'Courier Ops Desktop',
      summary: 'Electron desktop tool for courier ops: roles, shipments, tickets, PDFs.',
      summaryPl: 'Desktop Electron: role, przesyłki, tickety i raporty PDF.',
      description:
          'Desktop app for courier company operations — role-based panels (admin/manager/courier/warehouse), shipment statuses, tickets, and PDF report generation (Electron + Node.js + MySQL).',
      technologies: [
        'Electron',
        'Node.js',
        'MySQL',
        'Bootstrap',
        'PDFKit',
      ],
      previewImages: [],
      images: [],
    ),
    ProjectItem(
      id: 8,
      title: 'MacSpaceCleaner',
      summary: 'macOS disk cleaner: scan, rank junk, delete only after confirmation.',
      summaryPl: 'Czystka dysku na macOS: skan, ranking, usuwanie po potwierdzeniu.',
      description:
          'Desktop utility that scans system and external volumes for reclaimable space, ranks junk with heuristics, and deletes only after explicit user confirmation — safety-first UX.',
      technologies: [
        'C#',
        '.NET 9',
        'Avalonia',
      ],
      previewImages: [],
      images: [],
      githubUrl: 'https://github.com/AdrRojek/MacSpaceCleaner',
    ),
    ProjectItem(
      id: 9,
      title: 'Lotto Results App',
      phoneLayout: true,
      summary: 'SwiftUI lottery tracker with saved draws and official results in-app.',
      summaryPl: 'Tracker lotto w SwiftUI: zapisane losowania i oficjalne wyniki w aplikacji.',
      description:
          'Lotto Tracker lets you save your own draws (6 numbers 1–49) with timestamps and a Plus option, visually track matches, and open official results in a built-in browser.',
      technologies: [
        'SwiftUI',
        'SwiftData',
        'WebKit',
        'MVVM',
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
      id: 10,
      title: 'Bus Timetable Information',
      summary: 'Laravel system for admins, drivers, and passengers — routes and schedules.',
      summaryPl: 'System Laravel dla adminów, kierowców i pasażerów — trasy i rozkłady.',
      description:
          'Bus-Info streamlines public transport management: route planning, assignments, schedules, and role-based access for admins, drivers, and passengers.',
      technologies: ['PHP', 'Laravel', 'MySQL', 'Bootstrap', 'Git'],
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
      id: 11,
      title: 'Community Forum using Oracle database',
      summary: 'PHP forum with profiles, groups, surveys, and an Oracle database.',
      summaryPl: 'Forum PHP: profile, grupy, ankiety i baza Oracle.',
      description:
          'Online community forum: profiles, posts, comments, thematic groups, surveys, and friends — backed by a relational Oracle database.',
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
      id: 12,
      title: 'Car Mechanic Workshop',
      summary: 'Java + MySQL workshop manager: vehicles, repairs, mechanics, validation.',
      summaryPl: 'System warsztatu w Java + MySQL: pojazdy, naprawy, mechanicy, walidacja.',
      description:
          'Workshop management system with CRUD for vehicles, repairs, and mechanics, input validation, and a MySQL backend.',
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
