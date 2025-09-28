import en from './locales/en.json';
import ko from './locales/ko.json';

export const ui = {
    en,
    ko
};

export const languages = {
    en: 'English',
    ko: 'Korean'
};

export const defaultLang = 'en';
export const showDefaultLang = false;
export const languagesExceptDefault = Object.keys(languages).filter(lang => lang !== defaultLang);