/**
 * token本存储
 * 作者：王坤 2022-03
 */

import { LOCAL_TOKEN } from "./constants.js"
/**
 * 获取本地存储的token
 */
export const getLocalToken = () => localStorage.getItem(LOCAL_TOKEN) || '';
/**
 * 将token存储于本地
 */
export const setLocalToken = (token) => localStorage.setItem(LOCAL_TOKEN, token);

export const removeLocalToken = () => localStorage.removeItem(LOCAL_TOKEN);