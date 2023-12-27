import { check, sleep } from "k6";

import http from "k6/http";
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";
import { SharedOptions } from "./Shared.js";
import { getUniqueEmail, getAuthenticatedRequestHeaders } from "./utils.js";

export let options = SharedOptions;

export default function () {
  let username = getUniqueEmail();
  let headers = getAuthenticatedRequestHeaders();
  const id = "07775000";

  let response = http.post(
    `http://localhost:3001/api/v1/interactions/${id}/like`,
    {
      headers: headers,
    }
  );

  check(response, {
    "is status 200": (r) => r.status === 200,
  });
  sleep(1);
}

export function handleSummary(data) {
  return {
    "../reports/AddLike.html": htmlReport(data),
  };
}
