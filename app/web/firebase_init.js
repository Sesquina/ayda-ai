// Firebase web initialization (generated from provided config)
// You can include this script in your web-hosted Flutter build or other web pages.

// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyDThmwYlOudVlGWxrvT8MWNZgnQPoZ2imc",
  authDomain: "aydaai-1a95f.firebaseapp.com",
  databaseURL: "https://aydaai-1a95f-default-rtdb.firebaseio.com",
  projectId: "aydaai-1a95f",
  storageBucket: "aydaai-1a95f.firebasestorage.app",
  messagingSenderId: "1083305661141",
  appId: "1:1083305661141:web:622c1bd3034396744bc85c",
  measurementId: "G-GBL1R60VYT",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

export { app, analytics };
