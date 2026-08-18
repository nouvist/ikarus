#[macro_export]
macro_rules! impl_copy {
    ($type:ty) => {
        impl $type {
            #[frb(sync)]
            pub fn copy(&self) -> Self {
                self.clone()
            }
        }
    };
}
