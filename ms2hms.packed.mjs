import { readFile } from "node:fs/promises";

(async () => {
  /** @type {string} */
  const wasm = "./ms2hms.wasm";

  const pbytes = readFile(wasm);
  const pwasm = pbytes.then(WebAssembly.instantiate);

  const { module, instance } = await pwasm;
  const { exports } = instance;
  const { ms2hms_packed } = exports;

  const imax = 86400 * 1000 - 1;
  let okcnt = 0;
  for (let i=0; i<imax; i++){
    const packed = ms2hms_packed(i);

    const ms = packed & 0x3ff;
    const s = (packed >> 10) & 0x3f;
    const m = (packed >> 16) & 0x3f;
    const h = (packed >> 22);

    const hours = (i / 3600 / 1000) | 0; // | 0 to convert to int
    const minutes = ((i % 3600000) / 60000) | 0;
    const seconds = ((i % 60000) / 1000) | 0;
    const millis = i % 1000;

    const ok = [
      hours === h,
      minutes === m,
      seconds === s,
      millis === ms,
    ].every(b => b);

    okcnt += ok ? 1 : 0;
  }

  console.info({
    imax,
    okcnt,
  });

})();
