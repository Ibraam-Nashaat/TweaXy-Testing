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
  let payload = JSON.stringify({});
  let response = http.get(
    "http://localhost:3001/api/v1/trends/?limit=3&offset=0",
    payload,
    {
      headers: header,
    }
  );
  sleep(1);
}

export function handleSummary(data) {
  return {
    "../reports/GetTrends.html": htmlReport(data),
  };
}
