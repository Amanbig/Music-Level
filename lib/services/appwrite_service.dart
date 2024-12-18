import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppwriteService {
  final Client client;
  final Account account;
  final Databases database;
  final Storage storage;
  final GoogleSignIn googleSignIn;

  // Replace these with your actual values
  final String appwriteUrl = 'https://[YOUR_APPWRITE_URL]'; // Appwrite server URL
  final String projectId = '[YOUR_PROJECT_ID]'; // Appwrite Project ID
  final String databaseId = '[YOUR_DATABASE_ID]'; // Replace with your database ID
  final String collectionId = '[YOUR_COLLECTION_ID]'; // Collection ID for storing music data
  final String bucketId = '[YOUR_BUCKET_ID]'; // Bucket ID for storing audio files

  AppwriteService()
      : client = Client(),
        account = Account(Client()),
        database = Databases(Client()),
        storage = Storage(Client()),
        googleSignIn = GoogleSignIn();

  // Initialize the Appwrite client
  Future<void> init() async {
    client.setEndpoint(appwriteUrl) // Set the Appwrite URL
        .setProject(projectId); // Set the Appwrite Project ID
  }

  // Google Authentication Sign-In
  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User cancelled the sign-in
      }
      final googleAuth = await googleUser.authentication;

      // Now we use createOAuth2Session correctly
      final result = await account.createOAuth2Session(
        provider: OAuthProvider.google, // Correct OAuth provider enum
        success: 'YOUR_SUCCESS_URL', // Replace with your success URL
        failure: 'YOUR_FAILURE_URL', // Replace with your failure URL
      );
      return result;
    } catch (e) {
      print('Google sign-in error: $e');
      throw Exception('Error during Google sign-in');
    }
  }

  // Store music details in the database
  Future<Document?> storeMusicDetails({
    required String userId,
    required String name,
    required String musicType,
    required String lyrics,
    required String audioFileUrl,
  }) async {
    try {
      final document = await database.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        // Use null for documentId to auto-generate it
        documentId: 'unique()', // Appwrite will auto-generate the document ID
        data: {
          'userId': userId,
          'name': name,
          'musicType': musicType,
          'lyrics': lyrics,
          'audioFileUrl': audioFileUrl,
        },
      );
      return document;
    } catch (e) {
      print('Error storing music details: $e');
      return null;
    }
  }

  // Upload audio file to Appwrite storage
  Future<String?> uploadAudioFile(String filePath) async {
    try {
      final upload = await storage.createFile(
        bucketId: bucketId,
        file: InputFile.fromPath(path: filePath), fileId: '',
      );
      return upload.$id; // Returns the file ID for the uploaded file
    } catch (e) {
      print('Error uploading audio file: $e');
      return null;
    }
  }

  // Get the currently authenticated user
  Future<User?> getCurrentUser() async {
    try {
      final user = await account.get();
      return user;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    try {
      await account.deleteSession(sessionId: 'current');
      googleSignIn.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
