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

const generateRandomString = (length) => {
  let chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  let str = "";
  for (let i = 0; i < length; i++) {
    let index = Math.floor(Math.random() * chars.length);
    let char = chars[index];
    str += char;
  }
  return str;
};

const getUniqueEmail = () => {
  let username = generateRandomString(8);
  let domain = generateRandomString(5);
  let email = username + "@" + domain + ".com";
  return email;
};
