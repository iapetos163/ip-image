declare module 'text2png' {
  export interface Text2PngOptions {
    padding: number;
    [key: string]: unknown;
  }

  export default function text2png(
    text: string,
    options?: Text2PngOptions,
  ): Buffer;
}
