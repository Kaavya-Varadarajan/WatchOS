//
//  ContentView.swift
//  WatchOS WatchKit Extension
//
//  Created by Kaavya on 2022-02-08.
//

import SwiftUI
import AVFoundation


struct ContentView: View {
    
    let stockString:String
    
    init (stockString:String) {
        self.stockString = stockString
    }
    
    
    var synthVM = SynthViewModel()
    
    @StateObject var globalString = GlobalString()
    
    @StateObject var rateValue = GlobalString()
    
    
    var body: some View {
        ScrollView {
            VStack {
                MultiLineChartView(data: [(getStockString(s: stockString), GradientColors.green) ], title: stockString, rateValue: parseArray(s: getStockString(s: stockString)))
                Text(globalString.stringy)
            }
            Button(action: {
                HTTPClient.get(url: "http://138.197.170.87:5000/summary") { response in
                    var n = String(data: response.body,encoding: String.Encoding.utf8)
                    if let unwrappedName = n {
                        print(unwrappedName)
                        do {
                            globalString.stringy = parse(s:unwrappedName)
                        } catch {
                            print("Error")
                        }
                    } else {
                        print("Error")
                    }
                }
            }) {
                Text("Fetch Summary")
            }
            Button(action: {
                self.synthVM.speak(text: globalString.stringy)
            }) {
                Text("Play")
            }
        }
    }
    
    func parse(s:String) -> String {
        let str = s;
        let stockArray = getStockString(s: stockString)
        var result:String = "";
        
        let total = String(format: "%.2f",stockArray.reduce(0,+))
        let max = String(format: "%.2f",stockArray.max()!)
        let min = String(format: "%.2f",stockArray.min()!)
        let open = String(format:"%.2f",stockArray[0])
        let close = String(format:"%.2f",stockArray[stockArray.count-1])
        
        result = str.replacingOccurrences(of: "[Name]", with: stockString)
        result = result.replacingOccurrences(of: "[Open]", with: open)
        result = result.replacingOccurrences(of: "[Close]", with: close)
        result = result.replacingOccurrences(of: "[High]", with: max)
        result = result.replacingOccurrences(of: "[Low]", with: min)
        result = result.replacingOccurrences(of: "[Date]", with: "Dec 1,2021")
        result = result.replacingOccurrences(of: "[Volume]", with: total)
        result = result.replacingOccurrences(of: "[",with:"")
        result = result.replacingOccurrences(of: "]", with: "")
        return result
    }
}


func getStockString(s:String) -> Array<Double> {
    var Microsoft = [329.3988953,328.8100891,322.3435059,325.5169373,334.2289124,334.2788086,332.4126587,341.8331909,338.699646,327.6624756,333.9594727,324.2295837,323.1318359,319.2498779,326.6146545,332.5124817,333.9993896,341.7433777,340.5458374,341.2444153,338.6198425,335.6260376]
    var Tesla = [1095.0,1084.6,1015.0,1009.0,1051.8,1069.0,1003.8,1017.0,966.4,958.5,976.0,926.9,932.6,899.9,938.5,1008.9,1067.0,1093.9,1088.5,1086.2,1070.3,1056.8]
    var Amazon =
    [3443.7,3437.4
     ,3389.8,3427.4,3523.3,3523.2,3483.4
     ,3444.2,3391.4,3381.8,3466.3
     ,3377.4,3400.4,3341.6,3408.3,3420.7
     ,3421.4,3393.4,3413.2,3384.0
     ,3372.9,3334.3]
    var Google =
    [2832.4,2875.5,2850.4
     ,2875.9,2960.7,2974.4,2962.1,2973.5
     ,2934.1,2899.4,2947.4,2896.8,2856.1,2848.0
     ,2884.4,2939.0,2942.9
     ,2961.3,2929.0,2930.1,2920.1,2893.6]
    var Nvidia = [
        314.3,321.2,306.9,300.3,324.2
        ,318.2,304.8,301.9,281.6,283.3
        ,304.5,283.8,278.0,277.1,290.7
        ,293.9,296.3,309.4,303.2
        ,300.0,295.8,294.1
    ]
    var Starbucks = [
        108.1,110.9,110.7
        ,112.8,115.7,115.7
        ,114.8,116.1,115.0
        ,114.1,114.1,113.0
        ,108.1,107.5,109.8,111.2
        ,111.8,113.6,115.0,115.8,115.7,116.4
    ]
    
    var Facebook = [
        310.6,310.4
        ,306.8,317.9,322.8
        ,330.6,329.8,329.8
        ,334.5,333.7,341.7
        ,334.9,333.8,325.5,334.2
        ,330.5,335.2,346.2
        ,346.2,342.9,344.4,336.4
    ]
    
    var Netflix = [
        617.8,616.5,602.1
        ,612.7,625.6,628.1,611.0
        ,611.7,604.6,598.0,605.0
        ,591.1,586.7,593.7,604.9
        ,614.2,614.1,613.1,610.7,610.5,612.1,602.4
    ]
    
    var Peloton = [
        42.3,44.5,43.5
        ,42.5,41.8,45.9
        ,40.7,38.5,41.3,39.3,38.5
        ,39.8,42.5,38.7,39.2,37.8,38.6
        ,36.7,35.1,34.6
        ,37.2
        ,35.8
    ]
    
    var Micron = [
        85.1,82.8,81.5,82.4
        ,85.7,85.9,84.8,85.4
        ,84.3,83.2,85.6,82.6
        ,82.9,81.9,90.6,90.2,94.3
        ,94.3,92.8,96.1,93.8,93.2
    ]
    
    if(s == "Microsoft") {
        return Microsoft
    } else if(s == "Tesla") {
        return Tesla
    } else if(s == "Amazon") {
        return Amazon
    } else if(s == "Google") {
        return Google
    } else if(s == "Nvidia") {
        return Nvidia
    } else if(s == "Starbucks") {
        return Starbucks
    } else if(s == "Facebook") {
        return Facebook
    } else if(s == "Netflix") {
        return Netflix
    } else if(s == "Peloton") {
        return Peloton
    } else if(s == "Micron") {
        return Micron
    }
    
    return []
    
}

func parseArray(s:Array<Double>) -> Int {
    let rateValue = Int((s[s.count-1] - s[0]))
    return rateValue
}



struct WelcomeElement: Codable {
    let id: Int
    let s1, s2, s3: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(stockString: "Hello")
    }
}

class GlobalString: ObservableObject {
    @Published var stringy = ""
}

class SynthViewModel: NSObject {
    private var speechSynthesizer = AVSpeechSynthesizer()
    
    override init() {
        super.init()
        self.speechSynthesizer.delegate = self
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(utterance)
    }
}

extension SynthViewModel: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("started")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        print("paused")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {}
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {}
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {}
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("finished")
    }
}
