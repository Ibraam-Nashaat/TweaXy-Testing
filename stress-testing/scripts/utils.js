import http from "k6/http";
import { TestUser } from "./Shared.js";

const getAuthenticatedRequestHeaders = () => {
  let payload = JSON.stringify(TestUser[0]);
  let headers = {
    "Content-Type": "application/json",
  };

  let response = http.post("http://localhost:3000/api/v1/auth/login", payload, {
    headers: headers,
  });

  let token = response.data.token;

  return {
    "Content-Type": "application/json",
    Authorization: "Bearer " + token,
  };
};
