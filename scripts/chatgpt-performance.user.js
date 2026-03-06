// ==UserScript==
// @name         ChatGPT Performance Mode
// @namespace    local
// @version      2.0
// @description  Optimiert ChatGPT für lange Chats
// @match        https://chat.openai.com/*
// @match        https://chatgpt.com/*
// @run-at       document-idle
// ==/UserScript==

(function () {

'use strict';

const MAX_VISIBLE_MESSAGES = 120;
const KEEP_LAST_MESSAGES = 80;

function hideOldMessages(){

const messages=document.querySelectorAll('[data-message-author-role]');

if(messages.length>MAX_VISIBLE_MESSAGES){

const hideUntil=messages.length-KEEP_LAST_MESSAGES;

messages.forEach((msg,i)=>{
msg.style.display=i<hideUntil?'none':'';
});

}

}

function cleanUI(){

document.querySelectorAll('header,footer').forEach(el=>el.remove());

const sidebar=document.querySelector('[class*="sidebar"]');
if(sidebar) sidebar.remove();

}

function optimize(){
cleanUI();
hideOldMessages();
}

setInterval(optimize,2500);

})();
