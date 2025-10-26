//
//  TodayReminder.swift
//  Planto
//
//  Created by Wareef Saeed Alzahrani on 28/04/1447 AH.
//
import SwiftUI

struct TodayReminder: View {
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(width: 361, height: 8)
                    .cornerRadius(8)
                Rectangle()
                    .fill(Color.greeny)
                    .frame(width: 250, height: 8)
                    .cornerRadius(8)

            }
            
            List {
                
                HStack{
                    
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)                     .frame(width: 23, height: 23)
                    VStack(alignment: .leading)
{
                      
                        HStack{
                            
                            Image("Location")
                            Text("in Kitchen")
                                .font(.system(size: 13))
                        }
                        
                        Text("Monstera")
                            .font(.system(size: 28))
                        
                        HStack{
                            HStack{
                                Image("FullSun")
                                Text("Full sun")
                                    .font(.system(size: 13))

                            }
                            .padding(.horizontal,10)
                            .background{
                                RoundedRectangle(cornerRadius: 08)
                                    .fill(Color.green.opacity(0.5))
                            }
                            
                            HStack{
                                Image("Drop")
                                Text("20-50 ml")
                                    .font(.system(size: 13))
                            }
                            .padding(.horizontal,10)
                            .background{
                                RoundedRectangle(cornerRadius: 08)
                                    .fill(Color.gray.opacity(0.5))
                                
                            }
                            
                        }
                    }
                    
                    
                    
                    
                }
                HStack{
                    
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)                     .frame(width: 23, height: 23)
                    VStack(alignment: .leading)
{
                      
                        HStack{
                            
                            Image("Location")
                            Text("in Bedroom")
                                .font(.system(size: 13))
                        }
                        
                        Text("Pothos")
                            .font(.system(size: 28))
                        
                        HStack{
                            HStack{
                                Image("FullSun")
                                Text("Full sun")
                                    .font(.system(size: 13))

                            }
                            .padding(.horizontal,10)
                            .background{
                                RoundedRectangle(cornerRadius: 08)
                                    .fill(Color.green.opacity(0.5))
                            }
                            
                            HStack{
                                Image("Drop")
                                Text("20-50 ml")
                                    .font(.system(size: 13))
                            }
                            .padding(.horizontal,10)
                            .background{
                                RoundedRectangle(cornerRadius: 08)
                                    .fill(Color.gray.opacity(0.5))
                                
                            }
                            
                        }
                    }
                    
                    
                    
                    
                }
                HStack{
                    
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)                     .frame(width: 23, height: 23)
                    VStack(alignment: .leading)
{
                      
                        HStack{
                            
                            Image("Location")
                            Text("in Livingroom")
                                .font(.system(size: 13))
                        }
                        
                        Text("Orchid")
                            .font(.system(size: 28))
                        
                        HStack{
                            HStack{
                                Image("FullSun")
                                Text("Full sun")
                                    .font(.system(size: 13))

                            }
                            .padding(.horizontal,10)
                            .background{
                                RoundedRectangle(cornerRadius: 08)
                                    .fill(Color.green.opacity(0.5))
                            }
                            
                            HStack{
                                Image("Drop")
                                Text("20-50 ml")
                                    .font(.system(size: 13))
                            }
                            .padding(.horizontal,10)
                            .background{
                                RoundedRectangle(cornerRadius: 08)
                                    .fill(Color.gray.opacity(0.5))
                                
                            }
                            
                        }
                    }
                    
                    
                    
                    
                }
                HStack{
                    
                    Circle()
                        .stroke(Color.gray, lineWidth: 2)                     .frame(width: 23, height: 23)
                    VStack(alignment: .leading)
{
                      
                        HStack{
                            
                            Image("Location")
                            Text("in Kitchen")
                                .font(.system(size: 13))
                        }
                        
                        Text("Spider")
                            .font(.system(size: 28))
                        
                        HStack{
                            HStack{
                                Image("FullSun")
                                Text("Full sun")
                                    .font(.system(size: 13))

                            }
                            .padding(.horizontal,10)
                            .background{
                                RoundedRectangle(cornerRadius: 08)
                                    .fill(Color.green.opacity(0.5))
                            }
                            
                            HStack{
                                Image("Drop")
                                Text("20-50 ml")
                                    .font(.system(size: 13))
                            }
                            .padding(.horizontal,10)
                            .background{
                                RoundedRectangle(cornerRadius: 08)
                                    .fill(Color.gray.opacity(0.5))
                                
                            }
                            
                        }
                    }
                    
                    
                    
                    
                }
                
            }
            .navigationTitle(
                Text("My Plants 🌱"))

        }
    }
}
    
    #Preview
    {
        TodayReminder()
    }

