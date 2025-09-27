import type { AstroComponentFactory } from 'astro/runtime/server/index.js';
import type { HTMLAttributes, ImageMetadata } from 'astro/types';

export interface MetaData {
  title?: string;
  description?: string;
  canonical?: string;
  robots?: MetaDataRobots;
  openGraph?: MetaDataOpenGraph;
  twitter?: MetaDataTwitter;
}

export interface MetaDataRobots {
  index?: boolean;
  follow?: boolean;
}

export interface MetaDataOpenGraph {
  url?: string;
  title?: string;
  description?: string;
  images?: Array<MetaDataImage>;
  siteName?: string;
}

export interface MetatDataTwitter {
  handle?: string;
  site?: string;
  cardType?: string;
}

export interface MetaDataImage {
  url: string;
  alt?: string;
  type?: string;
  width?: number;
  height?: number;
}

export interface TimelineEvent {
  month: string;
  title: string;
  description: string;
  type: string;
}

export interface TimelineData {
  [year: string]: TimelineEvent[];
}