#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/mu-robotics/Documents/project_WS/src/yujin_ocs/yocs_ar_pair_approach"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/mu-robotics/Documents/project_WS/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/mu-robotics/Documents/project_WS/install/lib/python3/dist-packages:/home/mu-robotics/Documents/project_WS/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/mu-robotics/Documents/project_WS/build" \
    "/usr/bin/python3" \
    "/home/mu-robotics/Documents/project_WS/src/yujin_ocs/yocs_ar_pair_approach/setup.py" \
     \
    build --build-base "/home/mu-robotics/Documents/project_WS/build/yujin_ocs/yocs_ar_pair_approach" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/mu-robotics/Documents/project_WS/install" --install-scripts="/home/mu-robotics/Documents/project_WS/install/bin"
