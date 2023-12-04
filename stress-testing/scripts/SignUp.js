import { check, sleep } from "k6";

import http from "k6/http";
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";
import { SharedOptions, TestUserData } from "./Shared.js";

export let options = SharedOptions;

export default function () {
  let payload = JSON.stringify(TestUserData);
  let headers = {
    "Content-Type": "application/json",
  };

  let response = http.post(
    "http://localhost:3000/api/v1/auth/signup",
    payload,
    {
      headers: headers,
    }
  );

  check(response, {
    "is status 403": (r) => r.status === 403,
  });
  sleep(1);
}

export function handleSummary(data) {
  return {
    "../reports/SignUpReport.html": htmlReport(data),
  };
}
