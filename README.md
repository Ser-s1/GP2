## Flutter Final Projict

This program is a real estate brokerage tool that calculates the expected market value of a property based on fixed figures (and will eventually rely on files approved by the Real Estate Authority). This data is then used to generate a price quote. The program also calculates the mortgage amount based on your current financial situation. This application aims to facilitate access to accurate property information and inform users about their financial capabilities. The program uses natural language processing (currently Gemini) for a user-friendly interface and easier access to information.

# screens

# Home
<img width="236" height="425" alt="image" src="https://github.com/user-attachments/assets/d717b7f2-6436-4aff-8bf9-8a6cd3d3897c" />
<P>This page is simply a welcome and guidance page for registration or login.</P>

# Login
<img width="236" height="425" alt="image" src="https://github.com/user-attachments/assets/2894fc7f-bc7d-4c18-8780-a716499c749b" />
<P>On this page, the user either logs in or is redirected to a new registration page. linked to the Sopabass databases. If the conditions are met, the user can then enter the program.</P>

# Registration
<img width="236" height="425" alt="image" src="https://github.com/user-attachments/assets/d9013f26-d2ce-4876-bec0-767d8c85bb54" />
<P>Similar to the previous one, but for new registrations. If you register, you will be redirected to the login page.</P>

# Home Login
<img width="236" height="425" alt="image" src="https://github.com/user-attachments/assets/5722dccd-9202-40be-8401-f3fc1cf92c54" />
<P>This page is the program's main loop where the user asks a question, and the response is processed within the program before being answered by a Gemini client.</P>

# History Page
<img width="236" height="425" alt="image" src="https://github.com/user-attachments/assets/1ef31135-5653-4e76-b65b-7253fb26f21a" />
<P>The name says it all.</P>

# Menu
<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/294d9abf-d377-468a-b855-6756aa77f241" />
<P>It's similar to an application handling service.</P>

# Control Folder

# Button.dart
<P>It contains two redirection buttons, one to delete previous content when redirecting, and the other just for redirection. However, the redirection button for deleting previous content isn't working. I tried rewriting it and searching for it, but I couldn't figure out the exact problem; it just redirects like its counterpart.</P>

# control.dart 
<P>This file is specifically for working with Sopabass databases.</P>

# gemini_service.dart
<P>This file contains instructions for the Gemini client on how to handle client data.</P>

# logic.dart
<P>This file contains the calculations that the client can use in the gemini_service.dart file.</P>

# widgets.dart
<P>This file is one of the best in the project, but I haven't given it enough attention. It groups all the repeated widgets in one place.</P>

# Target group for work
<P>Citizens and anyone without experience in real estate and mortgage loans in Saudi Arabia, for this reason most of the information was in Arabic. While I did encounter some problems, but the outcome was worthwhile.</P>

# Final 
<P>I expect many are wondering why I didn't just summarize the AI ​​topic in a three-line code snippet and let it do the calculations instead of adding three help files(logic.dart,gemini_service.dart,properties_data.json). The reason is simple:

1- I want the application to be more personalized and give it specific permissions and information to operate.

2- For a personal reason: because I'm more deeply involved in AI, I wanted to learn how to work with AI in Dart and Flutter. I believe that any organization or company using AI should be more proactive in controlling its inputs and outputs to prevent randomness and predict responses.</P>

<P>Thank you for reading. It did take some time and effort, but all thanks go to the esteemed teacher Mohammed Al-Awashiz for opening this door for me – the door to Flutter. It's one of the most enjoyable programming languages ​​and has opened many horizons for me in understanding how structures work. Thank you all again.</P>

# اذا عندك اي سؤال ذا رقمي : 0593746102
## 📁 Project Structure

```text
lib/
├── main.dart                # The entry point of the Flutter application
├── assets/                  
│   └── properties_data.json # Local database containing district base prices and default specs
├── control/                 # Core logic, services, and reusable components
│   ├── Button.dart          # Custom BuildContext extensions for streamlined navigation
│   ├── control.dart         # Supabase authentication controller (Login/SignUp)
│   ├── gemini_service.dart  # Gemini AI configuration, system instructions, and tool handling
│   ├── logic.dart           # Core algorithms for land valuation and loan calculations
│   └── widgets.dart         # Custom reusable UI elements (e.g., TextFieldWidget)
└── screens/                 # Application UI screens
    ├── hestory.dart         # Chat/Valuation history screen
    ├── home.dart            # Main application home screen
    ├── home_login.dart      # Dashboard for authenticated users
    ├── login.dart           # User login interface
    └── registration.dart    # User registration interface
