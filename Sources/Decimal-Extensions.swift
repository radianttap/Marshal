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


extension NumberFormatter {
	///	Formatter which creates Decimal numbers,
	///	uses Locale.current
	static let decimalFormatter: NumberFormatter = {
		let nf = NumberFormatter()
		nf.locale = Locale.current
		nf.generatesDecimalNumbers = true
		nf.numberStyle = .decimal
		return nf
	}()

	///	Formatter which creates Decimal numbers,
	///	uses `en_US_POSIX` locale.
	///	Reason for this: way too many APIs are only every returning Decimal values using `.` as decimal separator.
	static let usDecimalFormatter: NumberFormatter = {
		let nf = NumberFormatter()
		nf.locale = Locale(identifier: "en_US_POSIX")
		nf.generatesDecimalNumbers = true
		nf.numberStyle = .decimal
		return nf
	}()
}


extension Decimal: ValueType {
	public static func value(from object: Any) throws -> Decimal {
		if let object = object as? String {
			if let decimal = NumberFormatter.decimalFormatter.number(from: object)?.decimalValue {
				return decimal
			} else if let decimal = NumberFormatter.usDecimalFormatter.number(from: object)?.decimalValue {
				return decimal
			}
			throw MarshalError.typeMismatch(expected: "String(DecimalNumber)", actual: object)
		}

		if object is NSDecimalNumber {
			guard let decimalNum = object as? NSDecimalNumber else {
				throw MarshalError.typeMismatch(expected: "DecimalNumber", actual: object)
			}
			return decimalNum.decimalValue
		}

		if object is NSNumber {
			guard let num = object as? NSNumber else {
				throw MarshalError.typeMismatch(expected: "Number", actual: object)
			}
			return num.decimalValue
		}

		guard let decimal = object as? Decimal else {
			throw MarshalError.typeMismatch(expected: "Decimal", actual: object)
		}

		return decimal
	}
}

extension NSDecimalNumber: ValueType {
	public static func value(from object: Any) throws -> NSDecimalNumber {
		if let object = object as? String {
			if let decimal = NumberFormatter.decimalFormatter.number(from: object) as? NSDecimalNumber {
				return decimal
			} else if let decimal = NumberFormatter.usDecimalFormatter.number(from: object) as? NSDecimalNumber {
				return decimal
			}
			throw MarshalError.typeMismatch(expected: "String(NSDecimalNumber)", actual: object)
		}

		if object is NSNumber {
			guard let number = object as? NSNumber else {
				throw MarshalError.typeMismatch(expected: "NSNumber with decimal value", actual: object)
			}
			return NSDecimalNumber(decimal: number.decimalValue)
		}

		guard let decimal = object as? NSDecimalNumber else {
			throw MarshalError.typeMismatch(expected: "NSDecimalNumber", actual: object)
		}

		return decimal
	}
}



