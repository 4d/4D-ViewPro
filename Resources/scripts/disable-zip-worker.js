/*!
 *
 * 4DView Pro library
 *
 * Copyright(c) 4D SAS.  All rights reserved.
 *
 */

/**
 * Workaround: no zip.js web worker while the page is served from file://.
 *
 * SpreadJS reads .sjs/.xlsx through zip.js, which runs its codec in a Web
 * Worker started from a blob: URL. A file:// document serializes its origin as
 * "null", so that URL is `blob:null/<uuid>`; Chromium derives an opaque origin
 * with no precursor from it, while the worker's StorageKey stays `file://`.
 * The two disagree, and a Debug libcef aborts on
 *
 *   content/browser/service_worker/service_worker_security_utils.cc
 *   DCHECK failed: ... null [internally: (nonce TBD) anonymous] and file://
 *   [internally: file://] should be equal.
 *
 * Release tolerates the same inconsistency silently.
 *
 * zip.js decides once, when its bundle is parsed:
 *
 *   var WEB_WORKERS_SUPPORTED = typeof Worker != "undefined";   // io.js:22484
 *   (useWebWorkers && WEB_WORKERS_SUPPORTED
 *       ? createWebWorkerInterface : createWorkerInterface)(...) // io.js:22523
 *
 * so hiding Worker before that bundle loads selects the in-page codec
 * (createWorkerInterface, io.js:22634). This file must therefore stay ahead of
 * the SpreadJS includes.
 *
 * Cost: inflate/deflate runs on the main thread, so importing or exporting a
 * large document blocks the UI.
 *
 * This is a workaround, not the fix. The fix is to stop serving the page from
 * file:// at all - see the Web component's CEF scheme registration.
 */
(function () {
    'use strict';

    if (location.protocol === 'file:' && typeof Worker !== 'undefined') {
        try {
            delete window.Worker;
        } catch (err) {
            window.Worker = undefined;
        }
    }
})();
