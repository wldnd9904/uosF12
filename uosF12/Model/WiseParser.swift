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
        }
    }
}
