import Foundation

struct Team: Codable {
    let team: String
    let colors: Colors
    var players: [Player] = []

    init(team: String, colors: Colors, players: [Player]) {
        self.team = team
        self.colors = colors
        self.players = players
    }

    // Custom decoder to handle missing values
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.team = try container.decodeIfPresent(String.self, forKey: .team) ?? "Unknown Team"
        self.colors = try container.decodeIfPresent(Colors.self, forKey: .colors) ?? Colors(primary: "white", secondary: "black")
        self.players = try container.decodeIfPresent([Player].self, forKey: .players) ?? []
    }

    enum CodingKeys: String, CodingKey {
        case team, colors, players
    }
}

struct Colors: Codable {
    let primary: String
    let secondary: String
}

struct Player: Codable {
    let name: String
    let position: String
    let number: Int
}

let positions = [
    "Goalkeeper", "Left Back", "Center Back", "Center Back", "Right Back",
    "Defensive Midfielder", "Left Midfielder", "Right Midfielder",
    "Attacking Midfielder", "Left Forward", "Right Forward"
]

let positionToNumbers: [String: [Int]] = [
    "Goalkeeper": [1],
    "Right Back": [2],
    "Left Back": [3],
    "Center Back": [4, 5],
    "Defensive Midfielder": [6],
    "Right Midfielder": [7],
    "Left Midfielder": [11],
    "Attacking Midfielder": [8, 10],
    "Right Forward": [9],
    "Left Forward": [10, 11]
]

let firstNames = [
    "Luca", "Kai", "Mateo", "Jasper", "Leo", "Felix", "Elias", "Arlo", "Omar", "Zane",
    "Milo", "Ezra", "Noah", "Julian", "Rafael", "Theo", "Hugo", "Caleb", "Emil", "Sami",
    "Ibrahim", "Remy", "Nico", "Rory", "Malik", "Adrian", "Rowan", "Max", "Tariq", "Enzo",
    "Otis", "Jonas", "Ayaan", "Bastian", "Diego", "Cai", "Isaac", "Yusuf", "Owen", "Silas",
    "Levi", "Marco", "Samir", "Elio", "Tobias", "Renzo"
]

let lastNames = [
    "Fernandez", "Kim", "Santos", "Nguyen", "Ali", "Silva", "Hassan", "Cruz", "Khan", "Müller",
    "Yamamoto", "Bakari", "Costa", "Ishikawa", "Garcia", "Schneider", "Lopez", "Kowalski", "Abdi", "Moreau",
    "Petrov", "Tanaka", "Jensen", "Dubois", "Osei", "Ivanov", "Morales", "Amini", "Meier", "Singh",
    "Kaur", "Davies", "Marino", "Pereira", "Salem", "Zhou", "Kobayashi", "Bautista", "Rahman", "Becker",
    "Nakamura", "Choudhury", "Rocha", "Andersson", "Ortiz", "Rossi", "Huang", "Bello", "Demir", "Aziz"
]

func generatePlayerRoster() -> [Player] {
    var names = Set<String>()
    var assignedNumbers = Set<Int>()
    var usedLastNames = Set<String>()
    var roster: [Player] = []

    for position in positions {
        var firstName: String = "" 
        var lastName: String = ""
        var name: String = ""

        repeat {
            firstName = firstNames.randomElement()!
            lastName = lastNames.randomElement()!

            name = "\(firstName) \(lastName)"
        } while names.contains(name) || usedLastNames.contains(lastName)

        names.insert(name)
        usedLastNames.insert(lastName)

        let possibleNumbers = positionToNumbers[position] ?? []
        let number = possibleNumbers.first(where: { !assignedNumbers.contains($0) }) ?? (12...99).first(where: { !assignedNumbers.contains($0) })!
        assignedNumbers.insert(number)

        roster.append(Player(name: name, position: position, number: number))
    }

    return roster
}

func generateTeamRosters(from teams: [Team]) -> [Team] {
    var finalTeams: [Team] = []
    for team in teams {
        let players = generatePlayerRoster()
        let newTeam = Team(team: team.team, colors: team.colors, players: players)
        finalTeams.append(newTeam)
    }
    return finalTeams
}

let teamsPath = "/Users/shon/Projects/Yokta Beginnings/asset-generator/teams.json"

let teamsJson = try Data(contentsOf: URL(fileURLWithPath: teamsPath))
let teams = try JSONDecoder().decode([Team].self, from: teamsJson)
let teamRosters = generateTeamRosters(from: teams)

for team in teamRosters {
    print("\(team):")
    for player in team.players {
        print("  \(player.position): \(player.name) \(player.number)")
    }
}

let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

if let jsonData = try? encoder.encode(teamRosters),
   let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)

    // Optional: Write to file
    let url = URL(fileURLWithPath: "complete-teams.json")
    try? jsonData.write(to: url)
}

