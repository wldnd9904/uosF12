import Foundation

class StringParser : NSObject, XMLParserDelegate {
    var ret = ""
    
    func getString(data: Data) -> Optional<String> {
        ret = ""
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
        if ret == "" {
            return nil
        } else {
            return ret
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if value == "" {
            return
        }
        ret.append(value)
    }
}


class ScoreReportParser : NSObject, XMLParserDelegate {
    var scoreReport = ScoreReport()
    var scoreReportDictionary:[String:String] = [:]
    var draftSubject: Subject?
    var subjectDictionary:[String:String] = [:]
    
    var subjectMode: Bool = false
    var tagName:String = ""
    
    func getScoreReport(data:Data) -> ScoreReport {
        scoreReport = ScoreReport()
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
        return scoreReport
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        scoreReport.totalPnt = Int(scoreReportDictionary["get_pnt"] ?? "") ?? 0
        scoreReport.totalSum = Float(scoreReportDictionary["sum_mrks"] ?? "") ?? 0
        scoreReport.totalAvg = Float(scoreReportDictionary["avg_mrks"] ?? "") ?? 0
        scoreReport.sum1 = Float(scoreReportDictionary["mrks1"] ?? "") ?? 0
        scoreReport.sum2 = Float(scoreReportDictionary["mrks2"] ?? "") ?? 0
        scoreReport.sum3 = Float(scoreReportDictionary["mrks3"] ?? "") ?? 0
        scoreReport.sum4 = Float(scoreReportDictionary["mrks4"] ?? "") ?? 0
        scoreReport.avg1 = Float(scoreReportDictionary["avg1"] ?? "") ?? 0
        scoreReport.avg2 = Float(scoreReportDictionary["avg2"] ?? "") ?? 0
        scoreReport.avg3 = Float(scoreReportDictionary["avg3"] ?? "") ?? 0
        scoreReport.avg4 = Float(scoreReportDictionary["avg4"] ?? "") ?? 0
        scoreReport.pnt1 = Int(scoreReportDictionary["pnt1"] ?? "") ?? 0
        scoreReport.pnt2 = Int(scoreReportDictionary["pnt2"] ?? "") ?? 0
        scoreReport.pnt3 = Int(scoreReportDictionary["pnt3"] ?? "") ?? 0
        scoreReport.pnt4 = Int(scoreReportDictionary["pnt4"] ?? "") ?? 0
    }
    //태그 시작
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.tagName = elementName
        if elementName == "mainList1" {
            subjectMode = true
        }
        if subjectMode && elementName == "list"{
            draftSubject = Subject()
        }
    }
    //태그 내용
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if  value == "" {return}
        if subjectMode {
            subjectDictionary[self.tagName] = value
        } else {
            scoreReportDictionary[self.tagName] = value
        }
    }
    //태그 끝
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "mainList1" {
            subjectMode = false
        }
        if subjectMode && elementName == "list"{
            draftSubject?.year = Int(subjectDictionary["sch_year"] ?? "") ?? 0
            switch subjectDictionary["smt_cd"]{
            case "10":
                draftSubject?.semester = .spring
            case "11":
                draftSubject?.semester = .summer
            case "20":
                draftSubject?.semester = .fall
            case "21":
                draftSubject?.semester = .winter
            default:
                break
            }
            draftSubject?.subjectCode = subjectDictionary["curi_no"] ?? ""
            draftSubject?.korName = subjectDictionary["curi_nm"] ?? ""
            draftSubject?.engName = subjectDictionary["curi_eng_nm"] ?? ""
            let subDivIndex = Int(subjectDictionary["up_cmp_div_cd"] ?? "") ?? 1
            if subDivIndex > 0 {
                draftSubject?.subjectDiv = .allCases[subDivIndex - 1]
            } else {
                draftSubject?.subjectDiv = .A01
            }
            draftSubject?.pnt = Int(subjectDictionary["pnt"] ?? "") ?? 0
            draftSubject?.grade = Float(subjectDictionary["mrks"] ?? "") ?? 0
            draftSubject?.gradeStr = subjectDictionary["conv_grade"] ?? ""
            draftSubject?.valid = subjectDictionary["efft_yn"]=="Y"
            draftSubject?.retry = subjectDictionary["re_tlsn_yn"]=="Y"
            scoreReport.Subjects.append(draftSubject!)
            subjectDictionary = [:]
        }
    }
}

class CreditsParser : NSObject, XMLParserDelegate {
    var credits = Credits()
    var draftCreditItem: CreditItem?
    var creditItemDictionary:[String:String] = [:]
    
    var creditItemMode: Bool = false
    var tagName:String = ""
    
    func getCredits(data:Data) -> Credits {
        credits = Credits()
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
        //순서 이상해서 부모 못 찾은 애들 다시 순회
        for credit in credits.etc {
            if(credit.parent != ""){
                let parentCand = (credits.major.child + credits.GE.child).filter{$0.name.contains(credit.parent)}
                if !parentCand.isEmpty {
                    parentCand[0].child.append(credit)
                    credits.etc = credits.etc.filter{$0 !== credit}
                }
            }
        }
        return credits
    }
    //태그 시작
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.tagName = elementName
        if elementName == "mainList1" {
            creditItemMode = true
        }
        if creditItemMode && elementName == "list"{
            draftCreditItem = CreditItem()
        }
    }
    //태그 내용
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if  value == "" {return}
        if creditItemMode {
            creditItemDictionary[self.tagName] = value
        }
    }
    //태그 끝
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "mainList1" {
            creditItemMode = false
        }
        if creditItemMode && elementName == "list"{
            if creditItemDictionary["cmp_div_nm"] == "졸업이수학점" {
                credits.pnt = Int(creditItemDictionary["get_pnt"] ?? "") ?? 0
                credits.min = Int(creditItemDictionary["new_min_pnt"] ?? "") ?? 0
                credits.max = Int(creditItemDictionary["new_max_pnt"] ?? "") ?? 0
                credits.cnt = Int(creditItemDictionary["cnt"] ?? "") ?? 0
            } else {
                draftCreditItem!.parent = creditItemDictionary["grdt_cmp_std_nm"] ?? ""
                draftCreditItem!.name = creditItemDictionary["cmp_div_nm"] ?? ""
                draftCreditItem!.pnt = Int(creditItemDictionary["get_pnt"] ?? "") ?? 0
                draftCreditItem!.min = Int(creditItemDictionary["new_min_pnt"] ?? "") ?? 0
                draftCreditItem!.max = Int(creditItemDictionary["new_max_pnt"] ?? "") ?? 0
                draftCreditItem!.cnt = Int(creditItemDictionary["cnt"] ?? "") ?? 0
                credits.CreditItems.append(draftCreditItem!)
                if draftCreditItem!.parent == "" && draftCreditItem!.name == "교양" {
                    credits.GE = draftCreditItem!
                } else if draftCreditItem!.parent == "" && draftCreditItem!.name == "전공" {
                    credits.major = draftCreditItem!
                } else if draftCreditItem!.name != "전공" && (draftCreditItem!.name.contains("전공")){
                    credits.major.child.append(draftCreditItem!)
                } else if draftCreditItem!.parent == "" && draftCreditItem!.name != "교양" && draftCreditItem!.name.contains("교양"){
                    credits.GE.child.append(draftCreditItem!)
                } else if draftCreditItem!.parent != "" {
                    let parentCand = (credits.major.child + credits.GE.child).filter{$0.name.contains(draftCreditItem!.parent)}
                    if !parentCand.isEmpty {
                        parentCand[0].child.append(draftCreditItem!)
                    } else {
                        credits.etc.append(draftCreditItem!)
                    }
                } else {
                    credits.etc.append(draftCreditItem!)
                }
                creditItemDictionary = [:]
            }
        }
    }
}

class SemesterParser : NSObject, XMLParserDelegate {
    var year = ""
    var semester = ""
    var tagname = ""
    
    func getYearAndSemester(data: Data) -> (String,String) {
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
        return (year,semester)
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        tagname = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if value == "" {return}
        if tagname == "strSmtCd" {
            semester = value
        } else if tagname == "strSchYear" {
            year = value
        }
    }
}

class RegistrationParser : NSObject, XMLParserDelegate {
    var ret:[Registration] = []
    var draftRegistraion:Registration = Registration()
    var tagname = ""
    
    func getRegistrations(data: Data) -> [Registration] {
        ret = []
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
        return ret
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        tagname = elementName
        if tagname == "list" {
            draftRegistraion = Registration()
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "list" {
            ret.append(draftRegistraion)
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if value == "" {return}
        if tagname == "curi_nm" {
            draftRegistraion.name = value
        } else if tagname == "pnt" {
            draftRegistraion.pnt = Int(value) ?? 1
        } else if tagname == "cert_detl_area_nm" {
            draftRegistraion.isMajor = value.contains("전공")
        }
    }
}

