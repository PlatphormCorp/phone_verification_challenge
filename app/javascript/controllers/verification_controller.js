import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "phoneNumber", "verificationCode",
    "error", "successVerified", "verificationCodeButton", "errorVerified"
  ]

  sendVerificationCode() {
    if (!this.validatePhoneNumber()) {
      return;
    }
    const phoneNumber = this.phoneNumberTarget.value
    fetch('/verify_phone', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ phoneNumber: phoneNumber })
    })
    .then(response => response.json())
    .then(data => {
      console.log(data)
      if(data.status === "success" && data.message === 'already verified') {
        this.successVerifiedTarget.textContent = "Verification successful - you're all set";
        this.errorVerifiedTarget.textContent = ''
      } else if(data.status === "success") {
        this.successVerifiedTarget.textContent = "";
        this.verificationCodeTarget.disabled = false;
        this.verificationCodeButtonTarget.disabled = false;
        this.errorTarget.textContent = "";
      } else {
        this.errorTarget.textContent = "Verification failed:" + data.errors + ". Please try again.";
      }
    })
    .catch(error => console.error(error))
  }

  validatePhoneNumber() {
    const phoneNumber = this.phoneNumberTarget.value;
    const only10Digits = /^\d{10}$/
    if (phoneNumber.match(only10Digits)) {
      this.errorTarget.textContent = "";
      return true;
    } else {
      this.errorTarget.textContent = "Phone number must be 10 digits long. Please exclude any dashes or spaces or country codes.";
      return false;
    }
  }


    verifyCode(event) {
      event.preventDefault()
      const verificationCode = this.verificationCodeTarget.value
      const phoneNumber = this.phoneNumberTarget.value
      fetch('/verify_phone/verification_code', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ phoneNumber: phoneNumber, verificationCode: verificationCode })
    })
    .then(response => response.json())
    .then(data => {
      console.log(data)
      if(data.status === "success") {
        this.successVerifiedTarget.textContent = "Verification successful - you're all set";
        this.errorVerifiedTarget.textContent = ''
      } else {
        this.errorVerifiedTarget.textContent = "Verification failed. Please try again.";
        this.successVerifiedTarget.textContent = ''
      }
    })
    .catch(error => console.error(error))
  }
}