use flutter_rust_bridge::frb;
use std::{ffi::c_void, process};
use windows::{
    Win32::{
        Foundation::{HWND, LPARAM},
        UI::WindowsAndMessaging::{EnumWindows, GetWindowThreadProcessId, SetForegroundWindow},
    },
    core::BOOL,
};

#[frb(opaque)]
#[derive(Debug, Clone, Copy)]
pub struct Window(usize);

struct SearchData {
    pid: u32,
    result: Option<HWND>,
}

impl Window {
    pub fn current() -> Self {
        Self::from_pid(process::id()).unwrap()
    }

    #[frb(ignore)]
    pub fn from_raw_hwnd(hwnd: HWND) -> Self {
        Self(hwnd.0 as usize)
    }

    pub fn from_hwnd(hwnd: usize) -> Self {
        Self(hwnd)
    }

    pub fn from_pid(pid: u32) -> Option<Self> {
        let mut data = SearchData { pid, result: None };

        extern "system" fn callback(hwnd: HWND, lparam: LPARAM) -> BOOL {
            let data = unsafe { &mut *(lparam.0 as *mut SearchData) };

            let mut current_pid = 0u32;
            unsafe { GetWindowThreadProcessId(hwnd, Some(&mut current_pid as *mut _)) };

            if current_pid == data.pid {
                data.result = Some(hwnd);
                return BOOL(0);
            }

            BOOL(1)
        }

        let p_data = &mut data as *mut SearchData as isize;
        _ = unsafe { EnumWindows(Some(callback), LPARAM(p_data)) };

        data.result.map(|it| Self(it.0 as usize))
    }

    #[frb(ignore)]
    pub fn hwnd(&self) -> HWND {
        HWND(self.0 as *mut c_void)
    }

    pub fn focus(&self) {
        _ = unsafe { SetForegroundWindow(self.hwnd()) };
    }
}
