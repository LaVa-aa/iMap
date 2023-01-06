//
//  ContentView.swift
//  iMap
//
//

import SwiftUI
import MapKit

struct City: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

final class PinsViewModel: ObservableObject {
    @Published var mapRect = MKMapRect()
    let cities:[City]
    init(cities: [City]){
        self.cities=cities
    }
    func fit(){
        let points = cities.map(\.coordinate).map(MKMapPoint.init)
        mapRect = points.reduce(MKMapRect.null){rect, point in let newRect = MKMapRect(origin: point, size: MKMapSize())
            return rect.union(newRect)
        }
    }
}

//øst eller syde ned af er minus
struct ContentView: View {
    
 /*   @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(
        latitude: 25.7617,
        longitude: 80.14765
        ),
        latitudinalMeters: 25000, longitudinalMeters: 25000)
    //CLLocationDistance er bar en duble
  */
    
          //   @State private var userTrackingmode: MapUserTrackingMode = .follow
    @ObservedObject var viewModel: PinsViewModel
    
       /*      @State private var  region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.7617, longitude: 80.1918),span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))*/
    var body: some View {
        VStack{
          /*  Map(coordinateRegion: $region, annotationItems: cities){ city in
                MapAnnotation(coordinate: city.coordinate) {
                    Circle()
                        .stroke(Color.pink)
                        .frame(width: 44, height: 44)
                        .strokeBorder(Color.blue,lineWidth: 4)
                    
                }*/
            Map (
                mapRect:$viewModel.mapRect,
                annotationItems: viewModel.cities
            ){
                city in MapPin(coordinate: city.coordinate, tint: .accentColor)
            }
            }
                .ignoresSafeArea()
                /*      Button("Zoom"){
                 region.span=MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
                 region.center = CLLocationCoordinate2D(
                 latitude: 40.7128, longitude: 74.0060)
                 } */
            }
        }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()(viewModel: PinsViewModel(cities = [
            City(coordinate:.init(latitude: 40.7128, longitude: 74.006)),
            City(coordinate: .init(latitude: 37.7749, longitude: 122.4194)),
            City(coordinate:.init(latitude: 47.6062, longitude: 122.3321))]))
    }
}
