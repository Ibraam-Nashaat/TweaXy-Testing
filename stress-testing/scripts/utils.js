import http from 'k6/http';
import { TestUser } from './Shared.js';

class TokenSingleton {
    constructor() {
        this.token = null;
    }

    async getToken() {
        if (!this.token) {
            let payload = JSON.stringify(TestUser[0]);
            let headers = {
                'Content-Type': 'application/json',
            };

            let response = await http.post(
                'http://localhost:3000/api/v1/auth/login',
                payload,
                {
                    headers: headers,
                }
            );

            this.token = JSON.parse(response.body).data.token;
        }

        return this.token;
    }
}

const tokenSingleton = new TokenSingleton();

export const getAuthenticatedRequestHeaders = async () => {
    let token = await tokenSingleton.getToken();

    return {
        'Content-Type': 'application/json',
        Authorization: 'Bearer ' + token,
    };
};

export const generateRandomString = (length) => {
    let chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    let str = '';
    for (let i = 0; i < length; i++) {
        let index = Math.floor(Math.random() * chars.length);
        let char = chars[index];
        str += char;
    }
    return str;
};

export const getUniqueEmail = () => {
    let username = generateRandomString(8);
    let domain = generateRandomString(5);
    let email = username + '@' + domain + '.com';
    return email;
};
