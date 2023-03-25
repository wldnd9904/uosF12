//
//  ScoreHelper.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/26.
//

import Foundation

class ScoreReportHelper {
    static func filteredSubjects(subjects: [Subject], filterYear: Int?, filterGrade: String?, filterDiv:SubjectDiv?, sortByGrade: Bool) -> [Subject] {
        return subjects.filter{ subject in
            ((filterYear == nil)||subject.year==filterYear) && ((filterGrade == nil)||subject.gradeStr==filterGrade) && ((filterDiv == nil)||subject.subjectDiv==filterDiv)
        }.sorted{
            sortByGrade ? $0.grade > $1.grade : (($0.year, $0.semester) < ($1.year, $1.semester))
        }
    }
    static func semesterGroupedSubjects(subjects: [Subject]) -> [[Subject]]{
        return Dictionary(grouping:subjects){
            "\($0.year)\($0.semester.sortOrder)"
        }.sorted{$0.0<$1.0}.map{$0.1.sorted{$0.gradeStr<$1.gradeStr}}
    }
    static func halfGroupedSubjects(subjects: [Subject]) -> [[Subject]]{
        return Dictionary(grouping:subjects){
            "\($0.year)\($0.semester.Half.sortOrder)"
        }.sorted{$0.0<$1.0}.map{$0.1.sorted{$0.gradeStr<$1.gradeStr}}
    }
    static func gradeGroupedSubjects(subjects: [Subject]) ->[[Subject]]{
        return Dictionary(grouping:subjects){
            $0.gradeStr
        }.sorted{$0.0<$1.0}.map{$0.1.sorted{$0.year<$1.year}}
    }
    static func pntSum(_ subjects:[Subject]) -> Int {
        return subjects.reduce(0){$0+$1.pnt}
    }
    static func averageGrade(_ subjects:[Subject]) -> Float {
        return (subjects.reduce(0.0){$0 + $1.grade * Float($1.pnt)})/Float(pntSum(subjects))
    }
}
