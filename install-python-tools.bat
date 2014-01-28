echo,
echo ------------------------------------------------------------------
echo Run this as a non-admin user.
echo
echo Non-global install. For some reason, virtualenv has problems if 
echo you install it as an admin and use it as a non-admin.
echo ------------------------------------------------------------------
echo,

echo,
echo ------------------------------------------------------------------
echo Add easy_install
echo ------------------------------------------------------------------
echo,

if not exist ez_setup.py (
    curl -O https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
)

python ez_setup.py --user

echo,
echo ------------------------------------------------------------------
echo Add pip
echo ------------------------------------------------------------------
echo,

if not exist get-pip.py (
    curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py
)

python get-pip.py --user

echo,
echo ------------------------------------------------------------------
echo Add virtualenv
echo ------------------------------------------------------------------
echo,

pip install virtualenv --user

echo,
echo ------------------------------------------------------------------
echo easy_install, pip, and virtualenv are installed!
echo ------------------------------------------------------------------
echo,
