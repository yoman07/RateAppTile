import Foundation

public enum RateAppUserAction {
    case like(value: Int), tapLike(value: Int), closeRate, writePositive, closeWriteReview, feedbackNegative, closeWriteFeedback, feedbackPositive
}
