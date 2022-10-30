//
//  BusinessPartnerDetailedView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 31/10/2022.
//

import SwiftUI
import MapKit

struct BusinessPartnerDetailedView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    @State var businessPartner: BusinessPartner
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.4750, longitude: 153.0158), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))

    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 0) {
                // MARK: Business Partner Image Section
                Image(businessPartner.image)
                    .frame(width: 320, height: 218, alignment: .center)
                    .cornerRadius(12)
                    .padding(.vertical, 24)
                    .clipped()
                
                // MARK: Business Partner Details Section
                HStack {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(businessPartner.name)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 18)
                        
                        Text("+61 123 456 789")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                        
                        Text(businessPartner.address)
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color("businessPartnerAddressColor"))
                            .padding(.bottom, 14)
                    }
                    .padding(.leading, 21)
                    Spacer()
                }
                .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                .cornerRadius(12)
                .padding(.bottom, 24)
                
                // MARK: Business Partner Location Section
                HStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Location")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 18)
                            .padding(.bottom, 8)

                        
                        Map(coordinateRegion: $region, interactionModes: [.zoom], showsUserLocation: true, userTrackingMode: .constant(.follow))
                                    .frame(width: 282, height: 139)
                                    .padding(.bottom, 19)
                    }
                    Spacer()
                }
                .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                .cornerRadius(12)
                
                Spacer()
            }
            .padding(.horizontal, 28)
            Spacer()
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
}

struct BusinessPartnerDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        let model = BusinessPartnerModel()
        NavigationView {
            BusinessPartnerDetailedView(businessPartner: model.restaurants[0])
        }
    }
}
