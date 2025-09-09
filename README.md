# PlugShareX 🔌⚡

A professional EV charging sharing platform - **Home-as-a-Charger** concept that allows EV owners to share their home chargers with other drivers.

## 🚀 Features

### Core Features
- **🔍 Charger Discovery**: Find available chargers nearby with real-time status
- **🏠 Host Onboarding**: Upload charger details, set availability, and pricing
- **📅 Booking System**: Book charging slots with date/time picker
- **💳 Payment Integration**: Secure payments with Razorpay/Stripe
- **⚡ Live Sessions**: Real-time charging monitoring and control
- **⭐ Reviews & Ratings**: Rate hosts and drivers after sessions
- **🔔 Push Notifications**: Booking confirmations and session updates

### Authentication
- Phone number authentication
- Google Sign-In
- Apple Sign-In (iOS)
- Email/password authentication

### Map & Location
- Google Maps integration
- Real-time charger locations
- Distance-based filtering
- Navigation to chargers

### Host Features
- Charger management dashboard
- Availability scheduling
- Pricing configuration
- Earnings tracking
- Session monitoring

### Driver Features
- Charger search and filtering
- Booking management
- Payment history
- Session tracking
- Route planning

## 🎨 Design System

### Modern UI/UX
- **Glassmorphism** overlays and effects
- **Soft gradients** and rounded corners
- **AI-designed** look similar to Airbnb + Apple Maps
- **Light/Dark** mode support
- **Smooth animations** and transitions

### Color Palette
- **Primary**: Indigo (#6366F1)
- **Secondary**: Emerald (#10B981)
- **Accent**: Amber (#F59E0B)
- **Neutral**: Gray scale (#FAFAFA to #171717)

### Typography
- **Font Family**: Inter (Google Fonts)
- **Weights**: Regular, Medium, SemiBold, Bold
- **Responsive** text sizing

## 🛠 Tech Stack

### Frontend
- **Flutter 3** + **Dart**
- **Riverpod** for state management
- **Go Router** for navigation
- **Google Maps Flutter** for maps
- **Flutter Animate** for animations

### Backend & Services
- **Firebase** (Auth, Firestore, Storage, Functions)
- **Google Maps API** for location services
- **Razorpay/Stripe** for payments
- **Firebase Cloud Messaging** for notifications

### Development Tools
- **Build Runner** for code generation
- **JSON Serializable** for data models
- **Hive** for local storage
- **Dio** for HTTP requests

## 📱 App Structure

```
lib/
├── core/
│   ├── constants/          # App constants
│   ├── theme/             # Theme configuration
│   ├── services/          # Core services
│   └── utils/             # Utility functions
├── features/
│   ├── auth/              # Authentication
│   ├── onboarding/        # Onboarding flow
│   ├── map/               # Map and discovery
│   ├── host/              # Host features
│   ├── booking/           # Booking system
│   ├── session/           # Live charging sessions
│   └── profile/           # User profiles
└── shared/
    ├── models/            # Data models
    ├── widgets/           # Shared widgets
    └── providers/         # State providers
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.8.1 or higher
- Dart SDK 3.8.1 or higher
- Android Studio / VS Code
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/plugsharex.git
   cd plugsharex
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project
   - Enable Authentication, Firestore, Storage, and Functions
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the respective platform folders

4. **Google Maps API**
   - Get a Google Maps API key
   - Update `lib/core/constants/app_constants.dart` with your API key

5. **Run the app**
   ```bash
   flutter run
   ```

### Environment Configuration

Create a `.env` file in the root directory:
```env
GOOGLE_MAPS_API_KEY=your_google_maps_api_key
STRIPE_PUBLISHABLE_KEY=your_stripe_key
RAZORPAY_KEY=your_razorpay_key
FIREBASE_PROJECT_ID=your_firebase_project_id
```

## 📊 Data Models

### User Model
- Authentication details
- Profile information
- Vehicle details (for drivers)
- Payment methods
- Preferences and settings

### Charger Model
- Location and address
- Technical specifications
- Pricing configuration
- Availability schedule
- Host information

### Booking Model
- Charger and user references
- Time slots and duration
- Payment status
- Session tracking
- Communication history

### Session Model
- Real-time charging data
- Energy consumption
- Cost calculation
- Status tracking
- OCPP integration

## 🔧 TODO & Integration Points

### Backend Integrations
- [ ] Firebase Authentication setup
- [ ] Firestore database configuration
- [ ] Cloud Functions for business logic
- [ ] Firebase Storage for images
- [ ] Push notification setup

### Payment Integration
- [ ] Stripe payment gateway
- [ ] Razorpay integration
- [ ] Payment webhooks
- [ ] Refund handling
- [ ] Payout system for hosts

### OCPP Integration
- [ ] OCPP client implementation
- [ ] Charger communication
- [ ] Remote start/stop
- [ ] Real-time monitoring
- [ ] Error handling

### Additional Features
- [ ] Admin panel (web)
- [ ] Analytics dashboard
- [ ] Dispute resolution system
- [ ] Multi-language support
- [ ] Offline mode

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run with coverage
flutter test --coverage
```

## 📦 Building

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Google Maps for location services
- Design inspiration from Airbnb and Apple Maps

## 📞 Support

For support, email support@plugsharex.com or join our Slack channel.

---

**PlugShareX** - Powering the future of EV charging, one home at a time! ⚡🔌
