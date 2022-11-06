//
//  GroomerLocation.swift
//  Petvely
//
//  Created by Hertz on 11/6/22.
//

import SwiftUI
import MapKit

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}

struct GroomerLocation: View {
    let place: IdentifiablePlace
    @State var region: MKCoordinateRegion

    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: [place])
        { place in
            MapMarker(coordinate: place.location,
                   tint: Color.purple)
        }
    }
}

struct GroomerLocation_Previews: PreviewProvider {
    static var previews: some View {
        GroomerLocation(place: IdentifiablePlace(lat: 127.039569, long: 37.645937), region: MKCoordinateRegion())
    }
}
