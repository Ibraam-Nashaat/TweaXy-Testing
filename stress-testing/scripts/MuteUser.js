import { check, sleep } from 'k6';
import http, { get } from 'k6/http';
import { htmlReport } from 'https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js';
import { SharedOptions, TestUser } from './Shared.js';
import {
    generateRandomString,
    getAuthenticatedRequestHeaders,
} from './utils.js';

export let options = SharedOptions;
let header = null;
export const setup = async () => {
    header = await getAuthenticatedRequestHeaders();
    return header;
};
export default function (header) {
    let payload = JSON.stringify({});
    let response = http.post(
        'http://localhost:3000/api/v1/users/password',
        payload,
        {
            headers: header,
        }
    );
    sleep(1);
}

export function handleSummary(data) {
    return {
        '../reports/MuteUser.html': htmlReport(data),
    };
}
