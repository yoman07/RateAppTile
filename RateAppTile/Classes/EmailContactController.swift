import Foundation
import UIKit
import MessageUI
import SVProgressHUD

final class RateAppEmailContactController: NSObject, MFMailComposeViewControllerDelegate {
    
    private let email: String
    private let subject: String
    private let body: String
    private let copyToClipboardText: String

    init(email: String,
         subject: String,
         body: String,
         copyToClipboardText: String) {
        self.email = email
        self.subject = subject
        self.body = body
        self.copyToClipboardText = copyToClipboardText
    }
    
    func present(from viewController: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            viewController.present(mail, animated: true)
        } else {
            copyToClipboard(email: email)
        }
    }
    
    private func copyToClipboard(email: String) {
        UIPasteboard.general.string = email
        SVProgressHUD.showInfo(withStatus: copyToClipboardMessage(email: email))
    }
    
    private func copyToClipboardMessage(email: String) -> String {
        return String(format: NSLocalizedString(self.copyToClipboardText,
                                                comment: "has_been_copied_to_clipboard"), email)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true)
    }
}
