//
//  About.swift
//  MHWDB
//
//  Created by Joe on 9/19/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct AboutView: View {

    var body: some View {
        List {
            ItemCell(
                icon: Icon(name: "mascot"),
                titleText: Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String,
                subtitleText: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            )

            Section(header: Text("Links").modifier(HeaderPadding())) {
                ItemCell(
                    // TODO: Should add a way to deal with images that stretch to edges unlike most of them
                    icon: .github,
                    titleText: "Github",
                    subtitleText: "This app is open source. Feel free to check out the code and contribute if you'd like!"
                ).modifier(LinkModifier(url: "https://github.com/JoeLago/MHWDB-iOS"))

                ItemCell(
                    icon: .github,
                    titleText: "MHWorld Data",
                    detailText: "Core Data Project"
                ).modifier(LinkModifier(url: "https://github.com/gatheringhallstudios/MHWorldData"))

                ItemCell(
                    icon: Icon(name: "discord"),
                    titleText: "Discord"
                ).modifier(LinkModifier(url: "https://discord.gg/k5rmEWh"))

                ItemCell(
                    icon: Icon(name: "mascot"),
                    titleText: "Gathering Hall Studios"
                ).modifier(LinkModifier(url: "http://gatheringhallstudios.com/"))
            }

            Section(header: Text("iOS Credits").modifier(HeaderPadding())) {
                ItemCell(
                    icon: Icon(name: WeaponType.chargeBlade.imageName, rarity: 9),
                    titleText: "Joe Lagomarsino"
                ).modifier(LinkModifier(url: "https://github.com/JoeLago"))
            }

            Section(header: Text("Android Credits").modifier(HeaderPadding())) {
                Text("Without all the hard work from the Gathering Hall Studio Android developers the iOS app would not exist.")
                    .font(.subheadline)
                    .padding(4)

                ItemCell(
                    icon: Icon(name: WeaponType.chargeBlade.imageName),
                    titleText: "Aaron Tang (Vocalonation)"
                ).modifier(LinkModifier(url: "https://github.com/ahctang"))

                ItemCell(
                    icon: Icon(name: WeaponType.greatSword.imageName),
                    titleText: "Carlos Fernandez (Supe)"
                ).modifier(LinkModifier(url: "https://github.com/CarlosFdez"))

                ItemCell(
                    icon: Icon(name: WeaponType.huntingHorn.imageName),
                    titleText: "Jayson Dela Cruz (jaysondc)"
                ).modifier(LinkModifier(url: "https://github.com/jaysondc"))

                ItemCell(
                    icon: Icon(name: "items_mantle_white"),
                    titleText: "Paul Tsouchlos (DeveloperPaul123)"
                ).modifier(LinkModifier(url: "https://github.com/DeveloperPaul123"))

                ItemCell(
                    icon: Icon(name: WeaponType.insectGlaive.imageName),
                    titleText: "Borislav Kosharov (nikibobi)"
                ).modifier(LinkModifier(url: "https://github.com/nikibobi"))
            }

            /* TODO: Setup translation files
            Section(header: Text("Translations").modifier(HeaderPadding())) {
                ItemCell(
                    icon: Icon(name: "hunter_notes"),
                    titleText: "Kailackous",
                    detailText: "Data (Past/Various)"
                )

                ItemCell(
                    icon: Icon(name: "hunter_notes"),
                    titleText: "Andy Flores",
                    detailText: "French"
                )

                ItemCell(
                    icon: Icon(name: "hunter_notes"),
                    titleText: "Scosciatacchini",
                    detailText: "Italian"
                )
            }
             */

            Section(header: Text("Resources").modifier(HeaderPadding())) {
                ItemCell(
                    icon: Icon(name: "items_ammo"),
                    titleText: "MHWDB Api"
                ).modifier(LinkModifier(url: "https://docs.mhw-db.com/"))

                ItemCell(
                    icon: Icon(name: "hunter_rank"),
                    titleText: "MHWG",
                    detailText: "Japanese Wiki"
                ).modifier(LinkModifier(url: "http://mhwg.org/"))

                ItemCell(
                    icon: Icon(name: "hunter_rank"),
                    titleText: "Kuroyonhon",
                    detailText: "Monster hitzones"
                ).modifier(LinkModifier(url: "http://kuroyonhon.com/mhw/"))

                ItemCell(
                    icon: Icon(name: "attack"),
                    titleText: "hexhexhex"
                ).modifier(LinkModifier(url: "https://twitter.com/MHhexhexhex"))

                ItemCell(
                    icon: Icon(name: "element"),
                    titleText: "Material",
                    detailText: "MHW Modding Data"
                ).modifier(LinkModifier(url: "https://discordapp.com/invite/gJwMdhK/"))

                ItemCell(
                    icon: Icon(name: "element_fire"),
                    titleText: "Asterisk",
                    detailText: "MHW Modding Data"
                ).modifier(LinkModifier(url: "https://discordapp.com/invite/gJwMdhK/"))

                ItemCell(
                    icon: Icon(name: "hunter_notes"),
                    titleText: "Kiranico"
                ).modifier(LinkModifier(url: "https://mhworld.kiranico.com/"))
            }

            Section(header: Text("Open Source Licenses").modifier(HeaderPadding())) {
                ItemCell(
                    icon: .github,
                    titleText: "GRDB.swift"
                ).modifier(LinkModifier(url: "https://github.com/groue/GRDB.swift"))

                ItemCell(
                    icon: .github,
                    titleText: "SwiftyUserDefaults"
                ).modifier(LinkModifier(url: "https://github.com/sunshinejr/SwiftyUserDefaults"))

                ItemCell(
                    icon: .github,
                    titleText: "SwiftlySearch"
                ).modifier(LinkModifier(url: "https://github.com/thislooksfun/SwiftlySearch"))
            }
        }
        .navigationBarTitle("About")
    }
}

extension Icon {
    static let github = Icon(name: "github", swiftColor: .primary)
}

struct LinkModifier: ViewModifier {
    @State var url: String

    @ViewBuilder
    func body(content: Content) -> some View {
        // TODO: after dropping iOS 13 we can use NavigationLinkView with url
        Button(
            action: {
                if let url = URL(string: url) {
                   UIApplication.shared.open(url)
               }
            },
            label: {
                HStack {
                    content
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 10)
                        .foregroundColor(.muted)
                }
            }
        )
    }
}
