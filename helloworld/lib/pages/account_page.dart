import 'package:flutter/material.dart';
import 'package:helloworld/pages/frame_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FramePage()),
            );
          },
        ),
        title: const Text(
          "Account",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sezione Profilo
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Username", // Da sostituire con dati Firebase
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "email@example.com", // Da sostituire con dati Firebase
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Sezione Informazioni Personali
              const Text(
                "User preferences",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text("Phone"),
                subtitle: const Text(
                    "+39 XXX XXX XXXX"), // Da sostituire con dati Firebase
                trailing: const Icon(Icons.edit),
                onTap: () {
                  // Azione per modificare il numero di telefono
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Address"),
                subtitle: const Text(
                    "Via Example, 123"), // Da sostituire con dati Firebase
                trailing: const Icon(Icons.edit),
                onTap: () {
                  // Azione per modificare l'indirizzo
                },
              ),

              const SizedBox(height: 15),

              // Sezione Preferenze
              const Text(
                "Preferences",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.sync),
                title: const Text("Auto update"),
                trailing: Switch(
                  value: false, // Da sostituire con dati Firebase
                  onChanged: (value) {
                    // Aggiorna preferenza sincronizzazione
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Pulsante Modifica Profilo
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    // Azione per modificare il profilo
                  },
                  child: const Text(
                    "Edit profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
