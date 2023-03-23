import Foundation

public enum WiseError: Error {
    case invalidServerResponse
    case loginFailed
    case dataMissing
    case duplicated
    case timeOut
    case sessionExpired
    case unknown
}
