//
//  M A R S H A L
//
//       ()
//       /\
//  ()--'  '--()
//    `.    .'
//     / .. \
//    ()'  '()
//
//

import Foundation

extension DateFormatter {
	static let iso8601Formatter: DateFormatter = {
		let df = DateFormatter()
		df.locale = Locale(identifier: "en_US_POSIX")
		df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		return df
	}()

	static let iso8601FractionalSecondsFormatter: DateFormatter = {
		let df = DateFormatter()
		df.locale = Locale(identifier: "en_US_POSIX")
		df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		return df
	}()
}

extension Date : ValueType {
	public static func value(from object: Any) throws -> Date {
		if let object = object as? Date { return object }

		guard let dateString = object as? String else {
			throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object))
		}

		if let date = DateFormatter.iso8601Formatter.date(from: dateString) {
			return date
		} else if let date = DateFormatter.iso8601FractionalSecondsFormatter.date(from: dateString) {
			return date
		}
		throw MarshalError.typeMismatch(expected: "ISO8601 date string", actual: dateString)
	}
}

