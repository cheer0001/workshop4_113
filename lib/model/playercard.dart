enum PlayerPic {
  card1(playerName: "Lionel Messi", image: "assets/images/images.jpg"),
  card2(playerName: "Cristiano Ronaldo", image: "assets/images/images (1).jpg"),
  card3(playerName: "Kylian Mbappé", image: "assets/images/images (2).jpg"),
  card4(playerName: "Jude Bellingham", image: "assets/images/images (3).jpg"),
  card5(playerName: "Thierry Henry", image: "assets/images/images (6).jpg"),
  card6(playerName: "Kevin De Bruyne", image: "assets/images/images (4).jpg");

  const PlayerPic({required this.playerName, required this.image});
  final String playerName;
  final String image;
}

class PlayerCard {
  final String name;
  final int number;
  final String nationality;
  final String club;
  final int age;
  final String heightWeight;
  final PlayerPic playerPic;

  PlayerCard({
    required this.name,
    required this.number,
    required this.nationality,
    required this.club,
    required this.age,
    required this.heightWeight,
    required this.playerPic,
  });
}

// ข้อมูลเริ่มต้น
List<PlayerCard> myCards = [
  PlayerCard(
    name: "Lionel Messi",
    number: 10,
    nationality: "Argentina",
    club: "Inter Miami",
    age: 36,
    heightWeight: "170 cm / 72 kg",
    playerPic: PlayerPic.card1,
  ),
];