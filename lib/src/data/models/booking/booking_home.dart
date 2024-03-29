class BookingHome {
  String id;
  String establishmentId;
  String establishmentName;
  String address;
  String petId;
  String petName;
  String petPicture;
  String date;
  String time;
  String status;
  int statusId;
  double establishmentLat;
  double establishmentLng;
  String establishmentPhone;
  bool vencido; //nuevo para store

  BookingHome({
    this.id,
    this.establishmentId,
    this.establishmentName,
    this.address,
    this.petId,
    this.petName,
    this.petPicture,
    this.date,
    this.time,
    this.status,
    this.statusId,
    this.establishmentLat,
    this.establishmentLng,
    this.establishmentPhone,
    this.vencido, //nuevo para store
  });

  factory BookingHome.fromJson(Map<String, dynamic> json) => BookingHome(
        id: json["id"],
        establishmentId: json["establishment_id"],
        establishmentName: json["establishment_name"],
        address: json["address"],
        petId: json["pet_id"],
        petName: json["pet_name"],
        petPicture: json["pet_picture"],
        date: json["date"],
        time: json["time"],
        status: json["status"],
        statusId: json["status_id"],
        establishmentLat: json["establishment_latitude"],
        establishmentLng: json["establishment_longitude"],
        establishmentPhone: json["establishment_phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "establishment_id": establishmentId,
        "establishment_name": establishmentName,
        "address": address,
        "pet_id": petId,
        "pet_name": petName,
        "pet_picture": petPicture,
        "date": date,
        "time": time,
        "status": status,
      };
}
