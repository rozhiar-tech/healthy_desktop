import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Dummy data for clinics
  List<Clinic> clinics = [
    Clinic(name: 'City Clinic 1', address: '123 Main St', owner: "Rozhiar"),
    Clinic(name: 'City Clinic 2', address: '456 Oak St', owner: "Azhy"),
    Clinic(name: 'City Clinic 3', address: '789 Pine St', owner: "Harem"),
    Clinic(name: 'City Clinic 4', address: '101 Elm St', owner: "Nawzhim"),
    Clinic(name: 'City Clinic 5', address: '202 Maple St', owner: "Ale"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinics in the City'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Set the number of columns you want
          crossAxisSpacing: 4.0, // Adjust the spacing between columns
          mainAxisSpacing: 4.0, // Adjust the spacing between rows
          childAspectRatio: 1.0, // Adjust the aspect ratio of each grid item
        ),
        itemCount: clinics.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClinicDetails(clinic: clinics[index]),
                ),
              );
            },
            child: ClinicCard(clinic: clinics[index]),
          );
        },
      ),
    );
  }
}

class Clinic {
  final String name;
  final String address;
  final String owner;

  Clinic({required this.name, required this.address, required this.owner});
}

class ClinicCard extends StatelessWidget {
  final Clinic clinic;

  ClinicCard({required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0), // Adjust the margin around each card
      child: ListTile(
        title: Text(
          clinic.name,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ), // Adjust the font size and weight of the title
        ),
        subtitle: Text(
          clinic.address,
          style: const TextStyle(fontSize: 12.0),
        ),
        // You can add more details or actions related to each clinic here
      ),
    );
  }
}

class ClinicDetails extends StatelessWidget {
  final Clinic clinic;

  ClinicDetails({required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${clinic.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clinic Name: ${clinic.name}'),
            Text('Clinic Address: ${clinic.address}'),
            Text('Clinic Owner: ${clinic.owner}'),
            const SizedBox(height: 16.0),
            const Text(
              'Rugs Information',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerLeft,
              child: DataTable(
                columnSpacing: 290,
                columns: const [
                  DataColumn(label: Text('Rug')),
                  DataColumn(label: Text('Expiry Date')),
                  DataColumn(label: Text('Buying Price')),
                  DataColumn(label: Text('Selling Price')),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text('Rug 1')),
                    DataCell(
                      // Check if the expiry date is expired
                      isDateExpired('2024-01-02')
                          ? const Text(
                              '2024-01-02',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text('2024-01-02'),
                    ),
                    const DataCell(Text('\$50')),
                    const DataCell(Text('\$100')),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Rug 2')),
                    DataCell(
                      // Check if the expiry date is expired
                      isDateExpired('2025-06-30')
                          ? const Text(
                              '2025-06-30',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text('2025-06-30'),
                    ),
                    const DataCell(Text('\$70')),
                    const DataCell(Text('\$120')),
                  ]),
                  // Add more rows as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isDateExpired(String date) {
    // Convert the string date to DateTime
    DateTime expiryDate = DateTime.parse(date);

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Check if the expiry date is before the current date
    return expiryDate.isBefore(currentDate);
  }
}
