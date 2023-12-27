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
  const username = "hamdysalem503_7479";
  let response = http.del(
    `http://localhost:3001/api/v1/users/block/${username}`,
    payload,
    {
      headers: header,
    }
  );
  sleep(1);
}

export function handleSummary(data) {
  return {
    "../reports/RemoveBlock.html": htmlReport(data),
  };
}
