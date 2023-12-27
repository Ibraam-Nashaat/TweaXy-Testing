import { check, sleep } from "k6";
import http, { get } from "k6/http";
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";
import { SharedOptions } from "./Shared.js";
import { getAuthenticatedRequestHeaders } from "./utils.js";

export let options = SharedOptions;
let header = null;
export const setup = async () => {
  header = await getAuthenticatedRequestHeaders();
  return header;
};
export default function (header) {
  let payload = JSON.stringify({
    token: "3341eecd@",
    email: "nesmashafie342@gmail.com",
  });
  let response = http.patch(
    "http://localhost:3000/api/v1/users/email",
    payload,
    {
      headers: header,
    }
  );
  check(response, {
    "is status 401": (r) => r.status === 401,
  });
  sleep(1);
}

export function handleSummary(data) {
  return {
    "../reports/UpdateEmail.html": htmlReport(data),
  };
}
