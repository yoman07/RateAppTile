import Foundation

public enum RateAppUserAction {
    case like(value: Int), tapLike(value: Int), closeRate, writePositive(value: String), closeWriteReview, feedbackNegative, closeWriteFeedback, feedbackPositive(value: String)

}
