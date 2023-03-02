const phoneNumber = document.querySelector("#phone-number");
const verificationToken = document.querySelector("#verification-token"); // change this to the thing at the top of the page
const authToken = document.querySelector('meta[name=csrf-token]');
const submitPhoneButton = document.querySelector("#submit-phone-number")
const submitVerificationCodeButton = document.querySelector("#submit-verification-code")
const prompt = document.querySelector("#prompt");

/*
* Todo:
*  add validation on key down
*
 */

submitPhoneButton.addEventListener('click', (e) => {
  handlePhoneSubmission();
})

submitVerificationCodeButton.addEventListener('click', (e) => {
  handleVerificationSubmission();
});

async function handlePhoneSubmission() {
  submitPhoneButton.disabled = true;
  const payload = {authenticity_token: authToken.content, phone: {number: phoneNumber.value}};
  const response = await request('/verify_phone', payload, 'POST');

  if (response.error_message) {
    submitPhoneButton.disabled = false;
    alert(response.error_message) // alerts are kinda lame
  } else {
    document.querySelector("#phone_id").value = response.id
    submitVerificationCodeButton.disabled = false;
    prompt.textContent = "You should receive a code any moment";
    verificationToken.disabled = false
    phoneNumber.disabled = true
  }
}

async function handleVerificationSubmission() {
  const phoneId = document.querySelector("#phone_id").value
  const payload = {authenticity_token: authToken.content, phone_number_verification: {token: verificationToken.value}};
  const response = request(`/phone/${phoneId}/verify_code`, payload, 'POST');

  if (response.error_message) { // handle with proper error codes somewhere I dont think this happens on a 500 for example
    alert(response.error_message) // alerts are kinda lame
  } else {
    submitVerificationCodeButton.disabled = true;
    verificationToken.disabled = true
    prompt.textContent = "Phone verified";
    phoneNumber.disabled = false
  }
}

async function request(path, payload, method) {
  const settings = {
    method: method,
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload)
  };

  try {
    const fetchResponse = await fetch(path, settings);
    const data = await fetchResponse.json();

    fetchResponse.headers.forEach((v, k) => {
      console.log(k)
      if (k === 'x-csrf-token') {
        document.querySelector('meta[name=csrf-token]').content = v
      }
    });
    return data;
  } catch (e) {
    console.error(e);
    return e;
  }
}
